const { GetCourseDetails } = require('../services/FECourseDetailsService');

exports.GetCourseDetailsController = async (req, res, next) => {
    try {
        const registerID = req.params.regNo;
        const coursecode = req.params.cCode;
        const password = req.body.password;
        
        // Call the GetCoursesTaughtByFaculty method from the service
        const result = await GetCourseDetails(registerID, password, coursecode);

        // Check the result
        if (result.success) {
            // Return faculty's courses
            res.status(200).json({ success: true, faculty: result.faculty });
        } else {
            // Return error message
            return res.status(400).json({ success: false, message: result.message });
        }
    } catch (error) {
        // Internal server error
        console.error('Error in getting course details:', error);
        return res.status(500).json({ success: false, message: 'Internal server error' });
    }
};
