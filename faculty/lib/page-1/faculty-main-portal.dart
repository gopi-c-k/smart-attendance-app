import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/page-1/configurations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/configurations.dart';
import 'package:flutter/material.dart'; // Import the material library for dialogs
import 'package:http/http.dart' as http;
import 'package:myapp/page-1/faculty-main-portal.dart';
import 'package:myapp/page-1/student-details-who-attended-class.dart';
import 'package:myapp/page-1/attendence-release-option.dart';

class FacultyMainPortalSFC extends StatefulWidget {
  @override
  FacultyMainPortalSF createState() => FacultyMainPortalSF();
}

class FacultyMainPortalSF extends State<FacultyMainPortalSFC> {
  List<Widget> courseWidgets = [];
  Map<String, dynamic> studentData = {};

  @override
  void initState() {
    super.initState();
    fetchStudentData(); // Call fetchStudentData function when the widget initializes
  }

  // Function to handle the POST request
  Future<void> fetchStudentData() async {
    final response = await http.post(
      Uri.parse(url+UserData.REGISTERNUMBER+'/FDashboard'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'password': UserData.PASSWORD,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      setState(() {
        studentData = json.decode(response.body);
        // Update UI with fetched data
      });
    } else {
      // If the server did not return a 200 OK response, show error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch student data'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to build custom course widgets based on student data
  List<Widget> buildCustomCourseWidgets(Map<String, dynamic> studentData, BuildContext context, double fem, double ffem) {
    List<Widget> courseWidgets = [];
    if (studentData.containsKey('faculty')) {
      List<dynamic> courses = studentData['faculty'];
      for (var course in courses) {
        String symbol;
        String text;
        if (course['attendanceStatus'] == true) {
          symbol = 'assets/page-1/images/depth-3-frame-0-6wy.png';
          text = 'Locked';
        } else {
          symbol = 'assets/page-1/images/depth-3-frame-0-Mpj.png';
          text = 'Edit';
        }
        courseWidgets.add(
          Container(
                    padding: EdgeInsets.fromLTRB(16 * fem, 12 * fem, 16 * fem, 12 * fem),
                    width: double.infinity,
                    height: 72 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xfff2f7f4),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // depth2frame0saf (1:147)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 54.53 * fem, 0 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16 * fem, 0 * fem),
                width: 48 * fem,
                height: 48 * fem,
                child: Image.asset(
                  symbol,
                  width: 48 * fem,
                  height: 48 * fem,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 1.5 * fem, 0 * fem, 1.5 * fem),
                width: 125.47 * fem,
                height: 48 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        '${course["courseCode"]} - ${course["courseName"]}',
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff0c1c17),
                        ),
                      ),
                    ),
                    Container(
                      width: 48 * fem,
                      height: 21 * fem,
                      child: Center(
                        child: Text(
                          'Slot: ${course["slot"]}',
                          style: TextStyle(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                            color: Color(0xff4c937f),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (course['attendanceStatus'] == true) {
                    // Handle locked status
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LockedStudentDetails(courseCode: course["courseCode"])),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendanceReleaseOption(courseCode: course["courseCode"],slot: course["slot"])),
                    );
                    // Handle edit status
                    // Navigate to the page where attendance can be edited
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff0c1c17),
                  ),
                ),
                  
                
              ),
                          
            ],
                          )
                        )
                      ]
          ),)
        );
      }
    }
    return courseWidgets;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 396;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    courseWidgets = buildCustomCourseWidgets(studentData, context, fem, ffem);
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Container(
          // facultymainportalfBm (1:132)
          width: double.infinity,
          height: 844 * fem,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Container(
            // depth0frame0zzj (1:133)
            width: 390 * fem,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff2f7f4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // depth1frame0XDy (1:134)
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
                  padding: EdgeInsets.fromLTRB(16 * fem, 28.75 * fem, 16 * fem, 20.75 * fem),
                  width: double.infinity,
                  height: 72 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xfff2f7f4),
                  ),
                  child: Container(
                    // depth4frame0Rq9 (1:137)
                    margin:EdgeInsets.fromLTRB(0 * fem, 0 * fem, 207.83 * fem, 0 * fem),
                    width: 150.17 * fem,
                    height: double.infinity,
                    child: Text(
                                           'Class Connect',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.25 * ffem / fem,
                        letterSpacing: -0.2700000107 * fem,
                        color: Color(0xff0c1c17),
                      ),
                    ),
                  ),
                ),
                Container(
                  // todayclasslist6RV (1:145)
                  margin: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 0 * fem, 11.5 * fem),
                  child: Text(
                    'Today class list',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.25 * ffem / fem,
                      letterSpacing: -0.3300000131 * fem,
                      color: Color(0xff0c1c17),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                courseWidgets.isNotEmpty
                    ? Column(
                        children: courseWidgets,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No classes today',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FacultyMainPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FacultyMainPortalSFC();
  }
}
