const mongoose = require('mongoose'); 
const Course = require('../model/schemacreation').Course;
const Faculty = require('../model/schemacreation').Faculty;

async function GetCourseDetails(registerID, password, coursecode) {
  try {
    const faculty = await Faculty.findOne({ registerID, password });
    if (!faculty) {
      return { success: false, message: 'Faculty not found' };
    }

    if (!faculty.teachingCourses || faculty.teachingCourses.length === 0) {
      return { success: false, message: 'Faculty has no assigned courses' };
    }
    const courses = await Course.find({ courseCode: { $in: faculty.teachingCourses } });

    const courseAttendeeDetails = courses.map(course => {
      if (coursecode === course.courseCode) {
        return {
          absentStudents: course.enrolledStudents
        };
      }
    }).filter(courseDetails => courseDetails !== undefined); 
    const enrolledStudentsLength = courseAttendeeDetails[0].absentStudents.length;// Remove undefined entries (optional)

    return { success: true, faculty: enrolledStudentsLength }; // Assuming a single course per request
  } catch (error) {
    console.error('Error in Getting Course Details:', error.message); // Log the error for debugging
    return { success: false, message: 'Error in getting courses Details' };
  }
}

module.exports = { GetCourseDetails };
