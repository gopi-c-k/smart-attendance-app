import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/request-with-scc.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/page-1/configurations.dart';

class AttendanceReleaseOptionSFC extends StatefulWidget{
    final String courseCode;
    final String slot;

  AttendanceReleaseOptionSFC({required this.courseCode,required this.slot});
  AttendanceReleaseOptionSF createState() => AttendanceReleaseOptionSF(courseCode: courseCode, slot: slot);
}
class AttendanceReleaseOptionSF extends State<AttendanceReleaseOptionSFC> {
    final String courseCode;
    final String slot;
     String numberOfStudent='';

  AttendanceReleaseOptionSF({required this.courseCode,required this.slot});
  void initState() {
    super.initState();
    fetchcourseData(); // Call fetchcourseData method when the widget is initialized
  }
  String _generateCode() {
    String code = '';
    // Generate random six-digit code
    final random = Random();
    for (int i = 0; i < 6; i++) {
      code += random.nextInt(10).toString();
    }
    return code;
  }
  Future<void> fetchcourseData() async {
    final response = await http.post(
      Uri.parse(url+UserData.REGISTERNUMBER+'/'+courseCode+'/FECourse'),
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
        numberOfStudent = jsonData['faculty'].toString();
      }
      });
    } else {
      // If the server did not return a 200 OK response, show error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch Course data'),
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
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = 396;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      //width: double.infinity,
      child: Container(
        // attendencereleaseoptionvwH (1:316)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Container(
          // depth0frame03FD (1:317)
          width: 390*fem,
          height: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xfff2f7f4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // depth1frame0kQX (1:318)
                padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 8*fem),
                width: double.infinity,
                height: 72*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f4),
                ),
                child: Container(
                  // autogroup3lw1fXV (CwUre1GVxp9xp54fVX3Lw1)
                  padding: EdgeInsets.fromLTRB(0*fem, 12*fem, 91.06*fem, 12*fem),
                  width: 310*fem,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame0NB1 (1:320)
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
                              'assets/page-1/images/depth-3-frame-0.png',
                              width: 24*fem,
                              height: 24*fem,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // depth4frame0e8X (1:326)
                        margin: EdgeInsets.fromLTRB(0*fem, 0.75*fem, 0*fem, 0.75*fem),
                        height: double.infinity,
                        child: Text(
                          'Release Attendance',
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
                // autogroupahd9WgX (CwUrPGC4jbG8nzkR6DAhd9)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 560*fem),
                padding: EdgeInsets.fromLTRB(16*fem, 4*fem, 16*fem, 12*fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // slotb11NP (1:333)
                      'Slot: $slot',
                      style: SafeGoogleFont (
                        'Plus Jakarta Sans',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5*ffem/fem,
                        color: Color(0xff0c1c17),
                      ),
                    ),
                    SizedBox(
                      height: 16*fem,
                    ),
                    Text(
                      // coursecodeswe2006uif (1:336)
                      'Course Code: $courseCode',
                      style: SafeGoogleFont (
                        'Plus Jakarta Sans',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5*ffem/fem,
                        color: Color(0xff0c1c17),
                      ),
                    ),
                    SizedBox(
                      height: 16*fem,
                    ),
                    Text(
                      // noofstudents60Rh1 (1:339)
                      'No. of Students: $numberOfStudent',
                      style: SafeGoogleFont (
                        'Plus Jakarta Sans',
                        fontSize: 16*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5*ffem/fem,
                        color: Color(0xff0c1c17),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                // depth1frame5APh (1:341)
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(16*fem, 12*fem, 16*fem, 12*fem),
                  width: double.infinity,
                  height: 72*fem,
                  child: TextButton(
                    // depth2frame0HDR (1:342)
                    onPressed: () {
                      String gets = _generateCode();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RequestWithSCC(courseCode: courseCode, slot: slot, code:gets)),
                    );
                  },
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(147.64*fem, 12*fem, 147.64*fem, 12*fem),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration (
                        color: Color(0xff7dd6bc),
                        borderRadius: BorderRadius.circular(24*fem),
                      ),
                      child: Container(
                        // depth3frame0yM9 (1:343)
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          color: Color(0xff7dd6bc),
                        ),
                        child: Center(
                          child: Text(
                            'Release',
                            style: SafeGoogleFont (
                              'Plus Jakarta Sans',
                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.5*ffem/fem,
                              letterSpacing: 0.2399999946*fem,
                              color: Color(0xff0c1c17),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // depth1frame647h (1:346)
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
class AttendanceReleaseOption  extends StatelessWidget {
  final String courseCode;
  final String slot;
  AttendanceReleaseOption({required this.courseCode,required this.slot});
  @override
  Widget build(BuildContext context) {
    return AttendanceReleaseOptionSFC(courseCode: courseCode,slot: slot);
  }
}