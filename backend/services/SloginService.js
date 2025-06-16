const Student = require('../model/schemacreation').Student; // Assuming Student model is exported correctly

class SloginService {
    static async SloginUser(UserID, Password) {
        try {
            // Find the student by UserID
            const student = await Student.findOne({ UserID });

            // If no student found
            if (!student) {
                return { success: false, message: 'Student not found' };
            }

            // Check if password matches
            if (student.Password !== Password) {
                return { success: false, message: 'Incorrect password' };
            }

            // Login successful
            return { success: true, student };
        } catch (error) {
            throw error;
        }
    }
}

module.exports = SloginService;


