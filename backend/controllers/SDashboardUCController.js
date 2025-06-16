const { GetStudentCourseAndFacultyDetails } = require('../services/SDashboardUCService');

exports.GetStudentCourseAndFacultyDetailsController = async (req, res, next) => {
    try {
        const registerNumber = req.params.regNo;
        const password = req.body.password;
        
        // Call the GetStudentCourseAndFacultyDetails method from the service
        const result = await GetStudentCourseAndFacultyDetails(registerNumber, password);

        // Check the result
        if (result.success) {
            // Return student's course and faculty details
            res.status(200).json({ success: true, student: result.student });
        } else {
            // Return error message
            return res.status(400).json({ success: false, message: result.message });
        }
    } catch (error) {
        // Internal server error
        console.error('Error in getting student course and faculty details:', error);
        return res.status(500).json({ success: false, message: 'Internal server error' });
    }
};
