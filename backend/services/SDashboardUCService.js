const Student = require('../model/schemacreation').Student;
const Course = require('../model/schemacreation').Course;
const Faculty = require('../model/schemacreation').Faculty;

async function GetStudentCourseAndFacultyDetails(RegisterNumber, password) {
    try {
        // Find the student based on RegisterNumber and password
        const student = await Student.findOne({ RegisterNumber, Password: password });
        if (!student) {
            return { success: false, message: 'Invalid RegisterNumber or Password' };
        }

        // Find all courses enrolled by the student
        const courses = await Course.find({ courseCode: { $in: student.CourseEnrolled } });

        // Prepare the result object
        const studentDetails = {
            RegisterNumber,
            courses: await Promise.all(courses.map(async course => ({
                courseCode: course.courseCode,
                courseName: course.courseName,
                venue: course.venue,
                slot: course.slot,
                attendanceStatus: course.attendanceStatus,
                facultyUsernames: await getFacultyUsernames(course.taughtBy)
            })))
        };

        return { success: true, student: studentDetails };
    } catch (error) {
        return { success: false, message: 'Error in getting student course and faculty details: ' + error.message };
    }
}

async function getFacultyUsernames(registerIDs) {
    try {
        // Find faculties based on register IDs
        const faculties = await Faculty.find({ registerID: { $in: registerIDs } });
        return faculties.map(faculty => faculty.username);
    } catch (error) {
        return [];
    }
}

module.exports = { GetStudentCourseAndFacultyDetails };
