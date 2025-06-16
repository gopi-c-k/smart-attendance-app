const mongoose = require('mongoose');
const { Course } = require('./schemacreation'); // Assuming your models are in a 'schemacreation.js' file
const uri = "mongodb+srv://gopick2004:GopiGopika2022@clusterclassconnect.fv2qvdh.mongodb.net/?retryWrites=true&w=majority&appName=ClusterClassConnect";


mongoose.connect(uri)
    .then(() => {
        console.log('Connected to MongoDB');

        // Define the course data
        const coursesData = [
            {
                courseCode: 'SWE1001',
                courseName: 'JAVA',
                venue: 'SJT808',
                slot: 'A1',
                taughtBy: '19778'
            },
            {
                courseCode: 'SWE2001',
                courseName: 'DSA',
                venue: 'SJTG03',
                slot: 'B1',
                taughtBy: '19776'
            },
            {
                courseCode: 'SWE3001',
                courseName: 'DBMS',
                venue: 'SJT214',
                slot: 'D1',
                taughtBy: '19776'
            },
            {
                courseCode: 'MGT1022',
                courseName: 'LSM',
                venue: 'SJT401',
                slot: 'C1',
                taughtBy: '19777'
            },
            {
                courseCode: 'MAT2002',
                courseName: 'STATS',
                venue: 'SJT114',
                slot: 'E1',
                taughtBy: '19777'
            }
        ];

        // Insert the courses into the database
        Course.insertMany(coursesData)
            .then((courses) => {
                console.log('Courses added successfully:', courses);
            })
            .catch((error) => {
                console.error('Error adding courses:', error);
            })
            .finally(() => {
                mongoose.disconnect(); // Disconnect from the database
            });
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error);
    });
