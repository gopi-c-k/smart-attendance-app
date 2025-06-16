import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/page-1/configurations.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/faculty-main-portal.dart';
import 'dart:io';
class FinalAttendeesDetailsSFC extends StatefulWidget{
  final List<String> attend;
  final String cc;
  FinalAttendeesDetailsSFC({required this.attend, required this.cc});
  FinalAttendeesDetailsSF createState() => FinalAttendeesDetailsSF(attend: attend, cc: cc);
}
class FinalAttendeesDetailsSF extends State<FinalAttendeesDetailsSFC> {
  
  final List<String> attend;
  final  String cc;
  FinalAttendeesDetailsSF({required this.attend, required this.cc});
  //final String sizeAsString = attend.length.toString();
  Future<void> updateAttendance(String courseCode, List<String> registerNumbers) async {
  // API endpoint URL
  String urls = url + 'updateAttendance/'+ courseCode;

  // Convert the list of register numbers to JSON format
  String requestBody = json.encode({"registerNumbers": registerNumbers});

  try {
    // Make the HTTP POST request
    final response = await http.post(
      Uri.parse(urls),
      headers: {
        "Content-Type": "application/json",
      },
      body: requestBody,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> responseData = json.decode(response.body);

      // Check the success field in the response
      if (responseData["success"]) {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>FacultyMainPortal() ),
      );
        print("Attendance updated successfully: ${responseData["message"]}");
      } else {
        // Show dialog if attendance update fails
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Attendance Update Failed"),
              content: Text(responseData["message"]),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      print("Failed to update attendance. Status code: ${response.statusCode}");
    }
  } catch (error) {
    print("Error updating attendance: $error");
  }
}
  

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      //width: double.infinity,
      child: Container(
        // finalattendeesdetailsWp7 (1:414)
        padding: EdgeInsets.fromLTRB(16*fem, 24*fem, 8*fem, 21*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xfff2f7f4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // timefinished1F5 (1:417)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
              child: Text(
                'Time Finished!',
                style: SafeGoogleFont (
                  'Plus Jakarta Sans',
                  fontSize: 32*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.25*ffem/fem,
                  letterSpacing: -0.8000000119*fem,
                  color: Color(0xff0c1c17),
                ),
              ),
            ),
            Container(
              // slota173D (1:420)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
              child: Text(
                'Slot: A1',
                style: SafeGoogleFont (
                  'Plus Jakarta Sans',
                  fontSize: 16*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xff0c1c17),
                ),
              ),
            ),
            Container(
              // coursecodeswe2005DM9 (1:423)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
              child: Text(
                'Course Code: $cc',
                style: SafeGoogleFont (
                  'Plus Jakarta Sans',
                  fontSize: 16*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xff0c1c17),
                ),
              ),
            ),
            Container(
              // noofstudents60iYo (1:426)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
              child: Text(
                'No. of Students: 60',
                style: SafeGoogleFont (
                  'Plus Jakarta Sans',
                  fontSize: 16*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xff0c1c17),
                ),
              ),
            ),
            /*
            Container(
              // noofpresentees58Ri7 (1:429)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
              child: Text(
                'No. of Presentees: $sizeAsString',
                style: SafeGoogleFont (
                  'Plus Jakarta Sans',
                  fontSize: 16*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xff0c1c17),
                ),
              ),
            ),*/
            Container(
              // noofabsentees2YGw (1:432)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 511*fem),
              child: Text(
                'No. of Absentees: 2',
                style: SafeGoogleFont (
                  'Plus Jakarta Sans',
                  fontSize: 16*ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.5*ffem/fem,
                  color: Color(0xff0c1c17),
                ),
              ),
            ),
            Container(
              // depth2frame0Tuh (1:434)
              margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 0*fem, 0*fem),
              child: TextButton(
                onPressed: () {
                  updateAttendance(cc,attend);
                  // Show dialog when button is pressed
                  /*showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Attendees Details"),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the details of the attendees
                              for (var attendee in attend)
                                Text(attendee),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                          ),
                        ],
                      );
                    },
                  );*/
                },
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(102.18*fem, 12*fem, 101.82*fem, 12*fem),
                  width: double.infinity,
                  height: 48*fem,
                  decoration: BoxDecoration (
                    color: Color(0xff7dd6bc),
                    borderRadius: BorderRadius.circular(24*fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame07jM (1:435)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                        width: 24*fem,
                        height: 24*fem,
                        child: Image.asset(
                          'assets/page-1/images/depth-3-frame-0-eTh.png',
                          width: 24*fem,
                          height: 24*fem,
                        ),
                      ),
                      Container(
                        // depth3frame12LX (1:439)
                        width: 122*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          color: Color(0xff7dd6bc),
                        ),
                        child: Center(
                          child: Text(
                            'Lock and Close',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          );
  }
}

class FinalAttendeesDetails  extends StatelessWidget {
  final List<String> attend;
  final String cc;
  FinalAttendeesDetails({required this.attend, required this.cc});
  @override
  Widget build(BuildContext context) {
    return FinalAttendeesDetailsSFC(attend: attend,cc: cc);
  }
}