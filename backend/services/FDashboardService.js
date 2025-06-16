const Course = require('../model/schemacreation').Course;
const Faculty = require('../model/schemacreation').Faculty;

async function GetCoursesTaughtByFaculty(registerID, password) {
    try {
        // Find the faculty based on registerID and password
        const faculty = await Faculty.findOne({ registerID, password });
        if (!faculty) {
            return { success: false, message: 'Invalid RegisterID or Password' };
        }

        // Find all courses taught by the faculty
        const courses = await Course.find({ courseCode: { $in: faculty.teachingCourses } });

        // Prepare the result object
        const coursesTaughtByFaculty = courses.map(course => ({
            courseCode: course.courseCode,
            courseName: course.courseName,
            slot: course.slot,
            attendanceStatus: course.attendanceStatus
        }));

        return { success: true, faculty: coursesTaughtByFaculty };
    } catch (error) {
        return { success: false, message: 'Error in getting courses taught by faculty: ' + error.message };
    }
}

module.exports = { GetCoursesTaughtByFaculty };
