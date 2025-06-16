const { ChangeUserID } = require('../services/SUserIDChangingService');

exports.ChangeUserIDDet = async (req, res, next) => {
    try {
        const  registerNumber  = req.params.regNo;
        const { NewUserID } = req.body;
        
        // Call the ChangeUserID method from the SUserIDChangingService
        const result = await ChangeUserID( registerNumber, NewUserID);

        // Check the result
        if (result.success) {
            // UserID Changed successfully, return the student details
            res.status(200).json({ success: true, message: 'UserID Changed successfully', student: result.student });
        } else {
            // Change UserID failed, return the error message
            return res.status(400).json({ success: false, message: result.message });
        }
    } catch (error) {
        // Internal server error
        console.error('Error in changing UserID:', error);
        return res.status(500).json({ success: false, message: 'Internal server error' });
    }
};
