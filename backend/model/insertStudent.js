const mongoose = require('mongoose');
const { Student } = require('./schemacreation');
const uri = "mongodb+srv://gopick2004:GopiGopika2022@clusterclassconnect.fv2qvdh.mongodb.net/?retryWrites=true&w=majority&appName=ClusterClassConnect";

mongoose.connect(uri)
    .then(() => {
        console.log('Connected to MongoDB');

        // Define the student data
        const studentsData = [
            {
                RegisterNumber: '22MIS0014',
                UserID: 'GOPIKA17122004',
                Password: '22MIS0014', // Initially password same as register number
                BluetoothIP: '',
                CourseEnrolled: ['SWE1001', 'SWE2001', 'SWE3001', 'MGT1022', 'MAT2002']
            },
            {
                RegisterNumber: '22MIS0058',
                UserID: 'GOPICK2004',
                Password: '22MIS0058',
                BluetoothIP: '',
                CourseEnrolled: ['SWE1001', 'SWE2001', 'SWE3001', 'MGT1022', 'MAT2002']
            },
            {
                RegisterNumber: '22MIS0062',
                UserID: 'SREERAM2005',
                Password: '22MIS0062',
                BluetoothIP: '',
                CourseEnrolled: ['SWE1001', 'SWE2001', 'SWE3001', 'MGT1022', 'MAT2002']
            },
            {
                RegisterNumber: '22MIS0066',
                UserID: 'SUGESHRAJ@ME',
                Password: '22MIS0066',
                BluetoothIP: '',
                CourseEnrolled: ['SWE1001', 'SWE2001', 'SWE3001', 'MGT1022', 'MAT2002']
            },
            {
                RegisterNumber: '22MIS0155',
                UserID: 'NATHIYA0155',
                Password: '22MIS0155',
                BluetoothIP: '',
                CourseEnrolled: ['SWE1001', 'SWE2001', 'SWE3001', 'MGT1022', 'MAT2002']
            }
        ];

        // Insert the students into the database
        Student.insertMany(studentsData)
            .then((students) => {
                console.log('Students added successfully:', students);
            })
            .catch((error) => {
                console.error('Error adding students:', error);
            })
            .finally(() => {
                mongoose.disconnect(); // Disconnect from the database
            });
    })
    .catch((error) => {
        console.error('Error connecting to MongoDB:', error);
    });
