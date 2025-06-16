const router = require('express').Router();
const SloginController = require('../controllers/SloginController');
const FloginController = require('../controllers/FloginController');
const SUserIDChangingController = require('../controllers/SUserIDChangingController');
const SPasswordChangingController = require('../controllers/SPasswordChangingController');
const SDashboardUCController = require('../controllers/SDashboardUCController'); // Import the new controller
const SDashboardCCController = require('../controllers/SDashboardCCController');
const FDashboardController = require('../controllers/FDashboardController');
const FLCourseController = require('../controllers/FLCourseController');
const FECourseDetailsController = require('../controllers/FECourseDetailsControllers');
// Route for student login
router.post('/StudentLogin', SloginController.Slogin);
router.post('/Flogin', FloginController.Flogin);
router.post('/:regNo/:cCode/FLCourse', FLCourseController.GetCourseAttendeeDetailsController);

router.post('/:regNo/:cCode/FECourse', FECourseDetailsController.GetCourseDetailsController);
// Route for changing student's password
router.post('/:regNo/changePassword', SPasswordChangingController.ChangePasswordDet);

// Route for changing student's UserID
router.post('/:regNo/changeUserID', SUserIDChangingController.ChangeUserIDDet);
router.post('/:regNo/FDashboard', FDashboardController.GetCoursesTaughtByFacultyController);
// Route for getting student's course and faculty details
router.post('/:regNo/SDashboardUC', SDashboardUCController.GetStudentCourseAndFacultyDetailsController);
router.post('/:regNo/SDashboardCC', SDashboardCCController.CCDashboardDet);
module.exports = router;
