const mongoose = require('mongoose');
const { Faculty } = require('./schemacreation'); // Assuming your models are in a 'schemacreation.js' file

const uri = "mongodb+srv://gopick2004:GopiGopika2022@clusterclassconnect.fv2qvdh.mongodb.net/?retryWrites=true&w=majority&appName=ClusterClassConnect";

mongoose.connect(uri)
    .then(() => {
        console.log('Connected to MongoDB');

        // Define the faculty data
        const facultyData = [
            {
                username: 'Nirmala M',
                registerID: '19778',
                password: '19778', // Initially password same as register ID
                teachingCourses: ['SWE1001']
            },
            {
                username: 'Seetha R',
                registerID: '19776',
                password: '19776',
                teachingCourses: ['SWE2001', 'SWE3001']
            },
            {
                username: 'Sridhar V G',
                registerID: '19777',
                password: '19777',
                teachingCourses: ['MGT1022', 'MAT2002']
            }
        ];

        // Insert the faculty into the database
        Faculty.insertMany(facultyData)
            .then((faculty) => {
                console.log('Faculty added successfully:', faculty);
            })
            .catch((error) => {
                console.error('Error adding faculty:', error);
            })
            .finally(() => {
                mongoose.disconnect(); // Disconnect from the database
            });
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error);
    });
