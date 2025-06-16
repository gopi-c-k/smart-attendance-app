const mongoose = require('mongoose'); 
const Course = require('../model/schemacreation').Course;
const Faculty = require('../model/schemacreation').Faculty;

async function GetCourseAttendeeDetails(registerID, password, coursecode) {
  try {
    // Find the faculty based on registerID and password
    const faculty = await Faculty.findOne({ registerID, password });
    if (!faculty) {
      return { success: false, message: 'Faculty not found' };
    }

    // Check for empty teachingCourses
    if (!faculty.teachingCourses || faculty.teachingCourses.length === 0) {
      return { success: false, message: 'Faculty has no assigned courses' };
    }

    // Find all courses taught by the faculty
    const courses = await Course.find({ courseCode: { $in: faculty.teachingCourses } });

    // Prepare the result object
    const courseAttendeeDetails = courses.map(course => {
      if (coursecode === course.courseCode) {
        return {
          presentStudents: course.presentStudents,
          absentStudents: course.enrolledStudents.filter(student => !course.presentStudents.includes(student)),
        };
      }
    }).filter(courseDetails => courseDetails !== undefined); // Remove undefined entries (optional)

    return { success: true, faculty: courseAttendeeDetails[0] }; // Assuming a single course per request
  } catch (error) {
    console.error('Error in GetCourseAttendeeDetails:', error.message); // Log the error for debugging
    return { success: false, message: 'Error in getting courses Attendee Details' };
  }
}

module.exports = { GetCourseAttendeeDetails };
