const Faculty = require('../model/schemacreation').Faculty; // Assuming Student model is exported correctly

class FloginService {
    static async FloginUser(registerID, Password) {
        try {
            // Find the student by UserID
            const faculty = await Faculty.findOne({ registerID });

            // If no student found
            if (!faculty) {
                return { success: false, message: 'Faculty not found' };
            }

            // Check if password matches
            if (faculty.password !== Password) {
                return { success: false, message: 'Incorrect password' };
            }

            // Login successful
            return { success: true, faculty };
        } catch (error) {
            throw error;
        }
    }
}

module.exports = FloginService;


