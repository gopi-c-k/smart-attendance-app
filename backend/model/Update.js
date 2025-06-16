const mongoose = require('mongoose');
const { Course } = require('./schemacreation'); // Import the Course model

// MongoDB connection URI
const uri = "mongodb+srv://gopick2004:GopiGopika2022@clusterclassconnect.fv2qvdh.mongodb.net/?retryWrites=true&w=majority&appName=ClusterClassConnect";

mongoose.connect(uri)
    .then(() => {
        console.log('Connected to MongoDB');

        // Define the course data
        const coursesToUpdate = [
            {
                courseCode: 'SWE3001',
                attendanceStatus: true,
                presentStudents: ['22MIS0155', '22MIS0062', '22MIS0066']
            }
            // Add more objects for additional courses to update
        ];

        // Update the courses in the database
        Promise.all(coursesToUpdate.map(course => {
            return Course.findOneAndUpdate(
                { courseCode: course.courseCode },
                { $set: { attendanceStatus: course.attendanceStatus }, $push: { presentStudents: { $each: course.presentStudents } } },
                { new: true }
            );
        }))
            .then(updatedCourses => {
                console.log('Courses updated successfully:', updatedCourses);
            })
            .catch(error => {
                console.error('Error updating courses:', error);
            })
            .finally(() => {
                mongoose.disconnect(); // Disconnect from the database
            });
    })
    .catch(error => {
        console.error('Error connecting to MongoDB:', error);
    });
    