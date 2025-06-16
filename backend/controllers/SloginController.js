const SloginService = require('../services/SloginService');

exports.Slogin = async (req, res, next) => {
    try {
        const { UserID, Password } = req.body;

        // Check if UserID and Password are provided
        if (!UserID || !Password) {
            return res.status(400).json({ success: false, message: 'UserID and Password are required' });
        }

        // Call the SloginUser method from the SloginService
        const loginResult = await SloginService.SloginUser(UserID, Password);

        // Check the login result
        if (loginResult.success) {
            // Login successful, return the student details
            res.status(200).json({ success: true, message: 'Login successful', student: loginResult.student });
        } else {
            // Login failed, return the error message
            return res.status(401).json({ success: false, message: loginResult.message });
        }
    } catch (error) {
        // Internal server error
        console.error('Error in student login:', error);
        return res.status(500).json({ success: false, message: 'Internal server error' });
    }
    //res.send('POST request received');
};
