const { GiveCCDashboard } = require('../services/SDashboardCCService');

exports.CCDashboardDet = async (req, res, next) => {
    try {
        const registerNumber = req.params.regNo;
        const { password } = req.body;
        
        // Call the GiveCCDashboard method from the CCDashboardService
        const result = await GiveCCDashboard(registerNumber, password);

        // Check the result
        if (result.success) {
            // Student course and faculty details fetched successfully
            res.status(200).json({ success: true, message: 'Student course and faculty details fetched successfully', student: result.student });
        } else {
            // Fetching student course and faculty details failed, return the error message
            return res.status(400).json({ success: false, message: result.message });
        }
    } catch (error) {
        // Internal server error
        console.error('Error in fetching student course and faculty details:', error);
        return res.status(500).json({ success: false, message: 'Internal server error' });
    }
};
