// Import the Student model
const Student = require('../model/schemacreation').Student;

// Define the service function to change the user ID based on register number
async function ChangePassword(RegisterNumber, newPassword) {
  try {
    // Update the document matching the RegisterNumber and return the updated document
    const filter = { RegisterNumber };
    const updateDoc = {
      $set: {
        Password : newPassword,
      },
    };

    // Check if a document was modified by the update (crucial for success)
    const result = await Student.updateOne(filter, updateDoc);
    if (result.modifiedCount > 0) {
      // Document was found and updated
      return { success: true, student: { RegisterNumber, newPassword } };
    } else {
      // Document not found or update didn't modify any fields
      return { success: false, message: `Register number ${RegisterNumber} not found in the database` };
    }
  } catch (error) {
    // Handle any errors
    return { success: false, message: 'Error in changing UserID: ' + error.message };
  }
}

// Export the service function
module.exports = { ChangePassword };
