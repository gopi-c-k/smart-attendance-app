import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/configurations.dart';
import 'package:flutter/material.dart'; // Import the material library for dialogs
import 'package:http/http.dart' as http;
import 'package:myapp/page-1/faculty-main-portal.dart';
class FacultyLoginSFC extends StatefulWidget{
  FacultyLoginSF createState() => FacultyLoginSF();
}
class FacultyLoginSF extends State<FacultyLoginSFC> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isNotValidateEmail = false;
  bool _isNotValidatePassword = false;
  void Flogin() async {
  // Check if username and password are not empty
  if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    // Prepare request body with username and password
    String userID = usernameController.text;
    String password = passwordController.text;

    try {
      Uri facultyLoginUri = Uri.parse(url + 'FLogin');
      // Send POST request to the server
      var response = await http.post(
        facultyLoginUri, // Replace 'uri' with your actual server endpoint
        body: json.encode({'UserID': userID, 'Password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      // Handle response
      if (response.statusCode == 200) {
        // Parse the response JSON
        var responseData = json.decode(response.body);
        String registerNumber = responseData['faculty']['registerID'];
        String userID = responseData['faculty']['username'];
 // Extract register number from response
        // Save user credentials and register number to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userID', userID);
        prefs.setString('password', password);
        prefs.setString('registerNumber', registerNumber);
        
        Navigator.push(
                      context,
                        MaterialPageRoute(builder: (context) => FacultyMainPortal()),
                    );
        UserData.loadData();
      } else {
        // Show popup for wrong password/username
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Wrong Password/Username'),
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
    } catch (e) {
      // Error occurred while sending request
      // Handle error here
    }
  } else {
    // Username or password is empty
    setState(() {
      _isNotValidateEmail = true;
      _isNotValidatePassword = true;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    double baseWidth = 396;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // facultyloginMQB (1:79)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Container(
          // depth0frame1R2f (1:697)
          padding: EdgeInsets.fromLTRB(0*fem, 25*fem, 0*fem, 0*fem),
          width: 390*fem,
          height: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xfff2f7f2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // frame3V2X (14:91)
                margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 0*fem, 323*fem),
                width: 275*fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      // autogroupku3mn1d (CwUoUGDKxWz3wKmvyCku3m)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 76*fem, 3*fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // cjb5 (14:92)
                            margin: EdgeInsets.fromLTRB(0*fem, 19*fem, 11*fem, 0*fem),
                            child: Text(
                              'C',
                              style: SafeGoogleFont (
                                'Plus Jakarta Sans',
                                fontSize: 128*ffem,
                                fontWeight: FontWeight.w700,
                                height: 0.17578125*ffem/fem,
                                letterSpacing: -0.2700000107*fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // lab7V (14:93)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19*fem),
                            child: Text(
                              'lass',
                              style: SafeGoogleFont (
                                'Plus Jakarta Sans',
                                fontSize: 48*ffem,
                                fontWeight: FontWeight.w700,
                                height: 0.46875*ffem/fem,
                                letterSpacing: -0.2700000107*fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      // onnectVCs (14:94)
                      'onnect',
                      style: SafeGoogleFont (
                        'Plus Jakarta Sans',
                        fontSize: 48*ffem,
                        fontWeight: FontWeight.w700,
                        height: 0.46875*ffem/fem,
                        letterSpacing: -0.2700000107*fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // depth1frame0zvK (1:734)
                padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 8*fem),
                width: double.infinity,
                height: 72*fem,
                decoration: BoxDecoration (
                  color: Color(0xfff2f7f2),
                ),
                child: Container(
                  // autogrouppe7qgo9 (CwUoErS1Gdw9QrauLbpe7q)
                  padding: EdgeInsets.fromLTRB(0*fem, 12*fem, 0*fem, 12*fem),
                  width: 310*fem,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth3frame0BV1 (1:736)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24*fem, 0*fem),
                        width: 24*fem,
                        height: 24*fem,
                        child: Image.asset(
                          'assets/page-1/images/depth-3-frame-0-8wH.png',
                          width: 24*fem,
                          height: 24*fem,
                        ),
                      ),
                      Container(
                        // depth3frame1Uj1 (1:741)
                        margin: EdgeInsets.fromLTRB(0*fem, 0.75*fem, 0*fem, 0.75*fem),
                        width: 262*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                        ),
                        child: Container(
                          // depth4frame0NpP (1:742)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 139.11*fem, 0*fem),
                          width: 122.89*fem,
                          height: double.infinity,
                          child: Text(
                            'Faculty Login',
                            style: SafeGoogleFont (
                              'Plus Jakarta Sans',
                              fontSize: 18*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.25*ffem/fem,
                              letterSpacing: -0.2700000107*fem,
                              color: Color(0xff0c1c0f),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // autogroupgtj1qxs (CwUnBYrpQu8iizrmt8gtj1)
                padding: EdgeInsets.fromLTRB(16*fem, 12*fem, 16*fem, 26*fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // depth3frame0MgK (1:722)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 33*fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // usernameUkw (1:724)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                            child: Text(
                              'Username',
                              style: SafeGoogleFont (
                                'Plus Jakarta Sans',
                                fontSize: 16*ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.5*ffem/fem,
                                color: Color(0xff0c1c0f),
                              ),
                            ),
                          ),
                          Container(
                            // depth5frame0b4s (1:726)
                            padding: EdgeInsets.fromLTRB(15*fem, 15*fem, 15*fem, 17*fem),
                            width: double.infinity,
                            height: 56*fem,
                            decoration: BoxDecoration (
                              border: Border.all(color: Color(0xffcce5d1)),
                              color: Color(0xfff2f7f2),
                              borderRadius: BorderRadius.circular(12*fem),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // depth6frame0Ggo (1:727)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 65*fem, 0*fem),
                                  width: 239*fem,
                                  height: double.infinity,
                                  child: TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration (
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorText: _isNotValidateEmail ? "Enter Valid Username" : null,
                                      hintText: 'Enter your username                               ',
                                      hintStyle: TextStyle(color:Color(0xff4c937f)),
                                    ),
                                    style: SafeGoogleFont (
                                      'Plus Jakarta Sans',
                                      fontSize: 16*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5*ffem/fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Container(
                                  // depth6frame1LRm (1:730)
                                  width: 24*fem,
                                  height: 24*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/depth-6-frame-1-xN3.png',
                                    width: 24*fem,
                                    height: 24*fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // depth3frame04Mm (1:708)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // passwordPQ3 (1:710)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 8*fem),
                            child: Text(
                              'Password',
                              style: SafeGoogleFont (
                                'Plus Jakarta Sans',
                                fontSize: 16*ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.5*ffem/fem,
                                color: Color(0xff0c1c0f),
                              ),
                            ),
                          ),
                          Container(
                            // depth5frame0uNP (1:712)
                            padding: EdgeInsets.fromLTRB(15*fem, 15*fem, 15*fem, 17*fem),
                            width: double.infinity,
                            height: 56*fem,
                            decoration: BoxDecoration (
                              border: Border.all(color: Color(0xffcce5d1)),
                              color: Color(0xfff2f7f2),
                              borderRadius: BorderRadius.circular(12*fem),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // depth6frame0CsH (1:713)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 11*fem, 0*fem),
                                  width: 293*fem,
                                  height: double.infinity,
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration (
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorText: _isNotValidatePassword ? "Enter Valid Password" : null,
                                      hintText: 'Enter your password                                                                                             ',
                                      hintStyle: TextStyle(color:Color(0xff4c937f)),
                                    ),
                                    style: SafeGoogleFont (
                                      'Plus Jakarta Sans',
                                      fontSize: 16*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5*ffem/fem,
                                      color: Color(0xff000000),

                                    ),
                                  ),
                                ),
                                Container(
                                  // depth6frame1fVy (1:716)
                                  width: 24*fem,
                                  height: 24*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/depth-6-frame-1.png',
                                    width: 24*fem,
                                    height: 24*fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // forgotpasswordPwm (1:705)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 24*fem),
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Plus Jakarta Sans',
                          fontSize: 14*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.5*ffem/fem,
                          color: Color(0xff4c937f),
                        ),
                      ),
                    ),
                    TextButton(
                      // depth2frame06bH (1:699)
                      onPressed: () {},
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(156.84*fem, 12*fem, 156.84*fem, 12*fem),
                        width: double.infinity,
                        height: 48*fem,
                        decoration: BoxDecoration (
                          color: Color(0xff7fd8be),
                          borderRadius: BorderRadius.circular(24*fem),
                        ),
                        child: TextButton(
                          // depth3frame0Qby (1:700)
                          onPressed: () {
                            Flogin();
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FacultyMainPortal()),
                    );*/
                  },
                          style: TextButton.styleFrom (
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              color: Color(0xff7fd8be),
                            ),
                            child: Text(
                              'Login',
                              style: SafeGoogleFont (
                                'Plus Jakarta Sans',
                                fontSize: 16*ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.5*ffem/fem,
                                letterSpacing: 0.2399999946*fem,
                                color: Color(0xff0c1c0f),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
          );
  }
}
class FacultyLogin  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FacultyLoginSFC();
  }
}