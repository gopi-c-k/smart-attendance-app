import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/page-1/configurations.dart';
class LockedStudentDetailsSFC extends StatefulWidget{
  final String courseCode;
  LockedStudentDetailsSFC({required this.courseCode});
  LockedStudentDetailsSF createState() => LockedStudentDetailsSF(courseCode: courseCode);
}

class LockedStudentDetailsSF extends State<LockedStudentDetailsSFC> {
  List<Widget> courseWidgets = [];
  Map<String, dynamic> courseData = {};
  final String courseCode;

  LockedStudentDetailsSF({required this.courseCode});
  @override
  void initState() {
    super.initState();
    fetchcourseData(); // Call fetchStudentData function when the widget initializes
  }
  Future<void> fetchcourseData() async {
    final response = await http.post(
      Uri.parse(url+UserData.REGISTERNUMBER+'/'+courseCode+'/FLCourse'),
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
        final jsonData = json.decode(response.body);
      if (jsonData['success']) {
        courseData = {
          'presentStudents': jsonData['faculty']['presentStudents'],
          'absentStudents': jsonData['faculty']['absentStudents']
        };
      }
      else {
        // If no students are present, set courseData to an empty list
        courseData = {
          'presentStudents': [],
          'absentStudents': [],
        };
      }});
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

  List<Widget> PresentWidgets = [];
  List<Widget> AbsentWidgets = [];
  void buildCustomCourseWidgets(Map<String, dynamic> studentData, BuildContext context, double fem, double ffem) {
  if (studentData.isNotEmpty) {
  List<dynamic> presentStudents = studentData['presentStudents'];
  List<dynamic> absentStudents = studentData['absentStudents'];

  // Adding present students' widgets
  for (var student in presentStudents) {
    Widget presentWidge = buildStudentWidget(student, fem, ffem,'assets/page-1/images/depth-3-frame-2-Eum.png');
    this.PresentWidgets.add(presentWidge);
  }

  // Adding absent students' widgets
  for (var student in absentStudents) {
    Widget absentWidge = buildStudentWidget(student, fem, ffem,'assets/page-1/images/depth-3-frame-3-7yZ.png');
    this.AbsentWidgets.add(absentWidge);
  }
}
}

Widget buildStudentWidget(String student, double fem, double ffem, String symbol) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Container(
          width: 40 * fem,
          height: 40 * fem,
          child: Image.asset(
            'assets/page-1/images/depth-3-frame-0-GUP.png',
            width: 40 * fem,
            height: 40 * fem,
          ),
        ),
        SizedBox(width: 16 * fem),
        Expanded(
          child: Text(
            student,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16 * ffem,
              fontWeight: FontWeight.w400,
              color: Color(0xff0c1c17),
            ),
          ),
        ),
        Container(
          width: 24 * fem,
          height: 24 * fem,
          child: Image.asset(
            symbol,
            width: 24 * fem,
            height: 24 * fem,
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    double baseWidth = 396;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    buildCustomCourseWidgets(courseData, context, fem, ffem);
    return SingleChildScrollView(
      //width: double.infinity,
      child: Container(
        // studentdetailswhoattendedclass (1:182)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Container(
          // depth0frame0AHV (1:183)
          width: 390*fem,
          height: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xfff2f7f4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // depth1frame0sxb (1:184)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 20*fem),
                padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 8*fem),
                width: double.infinity,
                height: 72*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f4),
                ),
                child: Container(
                  // autogroup3lakznK (CwUphjAFSEqm1Yps443LaK)
                  padding: EdgeInsets.fromLTRB(0*fem, 12*fem, 131.28*fem, 12*fem),
                  width: 310*fem,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame0K3u (1:186)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24*fem, 0*fem),
                        child: TextButton(
                          onPressed: () {
                    Navigator.pop(context);
                  },
                          style: TextButton.styleFrom (
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: 24*fem,
                            height: 24*fem,
                            child: Image.asset(
                              'assets/page-1/images/depth-3-frame-0-jvF.png',
                              width: 24*fem,
                              height: 24*fem,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // depth4frame01Bd (1:192)
                        margin: EdgeInsets.fromLTRB(0*fem, 0.75*fem, 0*fem, 0.75*fem),
                        height: double.infinity,
                        child: Text(
                          'Student Details',
                          style: SafeGoogleFont (
                            'Plus Jakarta Sans',
                            fontSize: 18*ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.25*ffem/fem,
                            letterSpacing: -0.2700000107*fem,
                            color: Color(0xff0c1c17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // studentdetailsVsV (1:200)
                margin: EdgeInsets.fromLTRB(16*fem, 0*fem, 0*fem, 11.5*fem),
                child: Text(
                  'Student Details',
                  style: SafeGoogleFont (
                    'Plus Jakarta Sans',
                    fontSize: 22*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.25*ffem/fem,
                    letterSpacing: -0.3300000131*fem,
                    color: Color(0xff0c1c17),
                  ),
                ),
              ),
              Container(
                // depth1frame21aw (1:201)
                padding: EdgeInsets.fromLTRB(16*fem, 8*fem, 32*fem, 8*fem),
                width: double.infinity,
                height: 56*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f4),
                ),
                child: Container(
                  // depth2frame0jWw (1:202)
                  padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 227*fem, 0*fem),
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame0551 (1:203)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                        width: 40*fem,
                        height: 40*fem,
                        child: Image.asset(
                          'assets/page-1/images/depth-3-frame-0-tJs.png',
                          width: 40*fem,
                          height: 40*fem,
                        ),
                      ),
                      Container(
                        // depth3frame1BNw (1:208)
                        margin: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 8*fem),
                        width: 59*fem,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            'Present',
                            style: SafeGoogleFont (
                              'Plus Jakarta Sans',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5*ffem/fem,
                              color: Color(0xff0c1c17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
                this.PresentWidgets.isNotEmpty
                    ? Column(
                        children: this.PresentWidgets,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'All Students are absent',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
              Container(
                // depth1frame6WvK (1:262)
                padding: EdgeInsets.fromLTRB(16*fem, 8*fem, 16*fem, 8*fem),
                width: double.infinity,
                height: 56*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f4),
                ),
                child: Container(
                  // depth2frame0TKm (1:263)
                  padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 203*fem, 0*fem),
                  width: 314*fem,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame0zKh (1:264)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                        width: 40*fem,
                        height: 40*fem,
                        child: Image.asset(
                          'assets/page-1/images/depth-3-frame-0-WgX.png',
                          width: 40*fem,
                          height: 40*fem,
                        ),
                      ),
                      Container(
                        // depth3frame1hE7 (1:269)
                        margin: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 8*fem),
                        width: 55*fem,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            'Absent',
                            style: SafeGoogleFont (
                              'Plus Jakarta Sans',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.5*ffem/fem,
                              color: Color(0xff0c1c17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
                this.AbsentWidgets.isNotEmpty
                    ? Column(
                        children: this.AbsentWidgets,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'All Students are present',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
              /*
              Container(
                // depth1frame8L47 (1:289)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 300.5*fem),
                padding: EdgeInsets.fromLTRB(16*fem, 8*fem, 0*fem, 8*fem),
                width: 416*fem,
                height: 56*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f4),
                ),
                child: Container(
                  // depth2frame0EvB (1:290)
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame0PHH (1:291)
                        width: 40*fem,
                        height: 40*fem,
                        child: Image.asset(
                          'assets/page-1/images/depth-3-frame-0-gqD.png',
                          width: 40*fem,
                          height: 40*fem,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),*/
              Container(
                // depth1frame10xdD (1:315)
                width: double.infinity,
                height: 20*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f4),
                ),
              ),
            ],
          ),
        ),
      ),
          );
  }
}
class LockedStudentDetails  extends StatelessWidget {
  final String courseCode;

  LockedStudentDetails({required this.courseCode});
  @override
  Widget build(BuildContext context) {
    return LockedStudentDetailsSFC(courseCode: courseCode);
  }
}