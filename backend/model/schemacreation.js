const mongoose = require('mongoose');
const { Schema } = mongoose;

// Student Schema
const studentSchema = new Schema({
    UserID: {
        type: String,
        required: true,
        unique: true
    },
    RegisterNumber: {
        type: String,
        required: true,
        unique: true
    },
    Password: {
        type: String,
        required: true
    },
    BluetoothIP: String,
    CourseEnrolled: {
        type: [String],
        required: true
    }
});

// Faculty Schema
const facultySchema = new Schema({
    username: {
        type: String,
        required: true,
        unique: true
    },
    registerID: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    teachingCourses: {
        type: [String],
        required: true
    }
});

// Course Schema
const courseSchema = new Schema({
    courseCode: {
        type: String,
        required: true,
        unique: true
    },
    courseName: {
        type: String,
        required: true
    },
    venue: String,
    slot: {
        type: String,
        required: true
    },
    attendanceStatus: {
        type: Boolean,
        default: false
    },
    enrolledStudents: {
        type: [String],
        default: []
    },
    presentStudents: {
        type: [String],
        default: []
    },
    taughtBy: {
        type: String,
        required: true
    }
});

module.exports = {
    Student: mongoose.model('Student', studentSchema),
    Faculty: mongoose.model('Faculty', facultySchema),
    Course: mongoose.model('Course', courseSchema)
};
