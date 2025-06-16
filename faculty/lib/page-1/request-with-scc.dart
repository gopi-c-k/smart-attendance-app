import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_nsd/flutter_nsd.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/final-attendees-details.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
class NSDService {
  static const MethodChannel _channel = MethodChannel('nsd_service');

  static Future<void> advertiseService(String serviceName, int port) async {
    try {
      await _channel.invokeMethod('advertiseService', {'serviceName': serviceName, 'port': port});
    } catch (e) {
      print('Error advertising NSD service: $e');
      throw e;
    }
  }
  static Future<void> stopService() async {
    try {
      await _channel.invokeMethod('stopService');
    } catch (e) {
      print('Error stopping NSD service: $e');
      throw e;
    }
  }
}
class NsdServer {
  List<String> messages = [];
  final String code;
  final String slot;
  final String cc;
  NsdServer({required this.code, required this.cc, required this.slot});
  ServerSocket? _serverSocket;
  bool _running = false;

  Future<void> startServer() async {
    try {
      _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);
      _running = true;
      _serverSocket!.listen((Socket clientSocket) {
    clientSocket.listen((List<int> data) {
        String message = String.fromCharCodes(data);

        // Check if the message is 'hello'
        if (message.trim().toLowerCase() == 'hello notify me') {
            // Send Slot:A1 Code:SWE2005
            clientSocket.writeln('Slot: $slot, Code: $cc');
        }
        // Check if the message contains 'It's from fingerprint'
        else if (message.contains("It's from fingerprint")) {
            // Send Slot:A1 Code:SWE2005 Num:123456
            clientSocket.writeln('Slot: $slot, Code: $cc, Number:$code');

        }
        else {
            // Store the message in an array without duplicates
            if (!messages.contains(message)) {
                messages.add(message);
            }
        }
    });
});

    } catch (e) {
      print('Error starting server: $e');
      throw e;
      //throw ErrorDetail(message: 'Error starting server: $e', stackTrace: stackTrace);
    }
  }

  Future<void> stopServer() async {
    if (_running) {
      await _serverSocket?.close();
      _running = false;
    }
  }

  bool isServerRunning() {
    return _running;
  }
}
class RequestWithSCCSFC extends StatefulWidget{
  final String courseCode;
  final String slot;
  final String code;
  RequestWithSCCSFC({required this.courseCode, required this.slot, required this.code});
  RequestWithSCCSF createState() => RequestWithSCCSF(courseCode: courseCode, slot: slot, code: code);
}
class RequestWithSCCSF extends State<RequestWithSCCSFC> {
  int minutes = 2;
  int seconds = 0;
  late Timer timer;
  final String courseCode;
  final String slot;
  final String code;
 // String code='';
  final NsdServer _nsdServer;

  RequestWithSCCSF({required this.courseCode, required this.slot, required this.code}) : _nsdServer = NsdServer(code: code, cc: courseCode, slot: slot);
  void initState() {
    super.initState();
    startTimer();
    init();
    //_generateCode();
    
    Future.delayed(Duration(minutes: 2), () {
      stop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FinalAttendeesDetails(attend: _nsdServer.messages,cc: courseCode)),
      );
    });
  }
//////////////////////////
void init () async {
  try {
        await _startNsdServer();
        await _startTcpServer();
      } catch (error) {
        throw error;
      }
}
void stop () async {
  try {
await _stopNsdServer();
                await _stopTcpServer();
      } catch (error) {
        throw error;
      }
}
Future<void> _startNsdServer() async {
    try {
      await NSDService.advertiseService('gopi', 3000);
    } catch (error) {
      throw error;
    }
  }

  Future<void> _stopNsdServer() async {
    try {
      await NSDService.stopService();
      
    } catch (error) {
      throw error;
    }
  }
  Future<void> _startTcpServer() async {
    try {
      await _nsdServer.startServer();
      ;
    } catch (error) {
   
      throw error;
    }
  }

  Future<void> _stopTcpServer() async {
    try {
      await _nsdServer.stopServer();
      
    } catch (error) {
     
      throw error;
    }
  }

///////////////////////////////
    void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else if (minutes > 0) {
          minutes--;
          seconds = 59;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 396;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
     // width: double.infinity,
      child: Container(
        // requestwithsccu5h (1:347)
        width: double.infinity,
        height: 844*fem,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: TextButton(
          // depth0frame0SrK (1:348)
          onPressed: () {},
          style: TextButton.styleFrom (
            padding: EdgeInsets.zero,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 181*fem),
            width: 390*fem,
            height: double.infinity,
            decoration: BoxDecoration (
              color: Color(0xfff2f7f4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogrouphr2bwYB (CwUs85J4bTV1mCd7btHr2B)
                  padding: EdgeInsets.fromLTRB(16*fem, 20*fem, 16*fem, 12*fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // requestsaresenttostudents58b (1:351)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                        constraints: BoxConstraints (
                          maxWidth: 267*fem,
                        ),
                        child: Text(
                          'Requests are sent to \nStudents',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont (
                            'Plus Jakarta Sans',
                            fontSize: 28*ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.25*ffem/fem,
                            letterSpacing: -0.6999999881*fem,
                            color: Color(0xff0c1c17),
                          ),
                        ),
                      ),
                      Container(
                        // slota1coursecodeswe2005dsa8cf (1:354)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 127*fem, 0*fem),
                        constraints: BoxConstraints (
                          maxWidth: 231*fem,
                        ),
                        child: Text(
                          'Slot:$slot\nCourse Code: $courseCode',
                          style: SafeGoogleFont (
                            'Plus Jakarta Sans',
                            fontSize: 16*ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5*ffem/fem,
                            color: Color(0xff0c1c17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // depth1frame21gT (1:355)
                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                  padding: EdgeInsets.fromLTRB(16*fem, 8*fem, 16*fem, 8*fem),
                  width: double.infinity,
                  height: 56*fem,
                  decoration: BoxDecoration (
                    color: Color(0xfff2f7f4),
                  ),
                  child: Container(
                    // depth2frame0ias (1:356)
                    padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 160*fem, 0*fem),
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // depth3frame0T2f (1:357)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                          width: 40*fem,
                          height: 40*fem,
                          child: Image.asset(
                            'assets/page-1/images/depth-3-frame-0-wkB.png',
                            width: 40*fem,
                            height: 40*fem,
                          ),
                        ),
                        Container(
                          // depth3frame1M83 (1:362)
                          margin: EdgeInsets.fromLTRB(0*fem, 8*fem, 0*fem, 8*fem),
                          width: 142*fem,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              'Secret Class Code',
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
                Container(
                  // depth1frame32zs (1:365)
                  margin: EdgeInsets.fromLTRB(21*fem, 0*fem, 21*fem, 12*fem),
                  width: double.infinity,
                  height: 56*fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // depth2frame0wc3 (1:366)
                        width: 48*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffcce5dd)),
                        ),
                        child: Center(
                          child: Text(
                            '${code[0]}',
                            textAlign: TextAlign.center,
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
                      SizedBox(
                        width: 12*fem,
                      ),
                      Container(
                        // depth2frame1pQw (1:370)
                        width: 48*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffcce5dd)),
                        ),
                        child: Center(
                          child: Text(
                            '${code[1]}',
                            textAlign: TextAlign.center,
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
                      SizedBox(
                        width: 12*fem,
                      ),
                      Container(
                        // depth2frame2Jb1 (1:374)
                        width: 48*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffcce5dd)),
                        ),
                        child: Center(
                          child: Text(
                            '${code[2]}',
                            textAlign: TextAlign.center,
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
                      SizedBox(
                        width: 12*fem,
                      ),
                      Container(
                        // depth2frame3Nqm (1:378)
                        width: 48*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffcce5dd)),
                        ),
                        child: Center(
                          child: Text(
                            '${code[3]}',
                            textAlign: TextAlign.center,
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
                      SizedBox(
                        width: 12*fem,
                      ),
                      Container(
                        // depth2frame4snX (1:382)
                        width: 48*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffcce5dd)),
                        ),
                        child: Center(
                          child: Text(
                            '${code[4]}',
                            textAlign: TextAlign.center,
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
                      SizedBox(
                        width: 12*fem,
                      ),
                      Container(
                        // depth2frame58yM (1:386)
                        width: 48*fem,
                        height: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xffcce5dd)),
                        ),
                        child: Center(
                          child: Text(
                            '${code[5]}',
                            textAlign: TextAlign.center,
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
                Container(
                  // depth1frame63Kd (1:390)
                  padding: EdgeInsets.fromLTRB(22*fem, 19*fem, 10*fem, 183*fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // endsinA9M (1:394)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 22*fem),
                        child: TextButton(
                          onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinalAttendeesDetails()),
                    );*/
                  },
                          style: TextButton.styleFrom (
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Ends in:',
                            textAlign: TextAlign.center,
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
                      Container(
                        // depth1frame43U3 (1:395)
                        width: double.infinity,
                        height: 93*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // depth2frame0ysV (1:396)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                              width: 171*fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // depth3frame07Tu (1:397)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                    width: double.infinity,
                                    height: 56*fem,
                                    decoration: BoxDecoration (
                                      color: Color(0xffe0efea),
                                      borderRadius: BorderRadius.circular(12*fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${minutes.toString().padLeft(2, '0')}',
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
                                  ),
                                  Container(
                                    // minutesym1 (1:404)
                                    margin: EdgeInsets.fromLTRB(0.08*fem, 0*fem, 0*fem, 0*fem),
                                    child: Text(
                                      'Minutes',
                                      style: SafeGoogleFont (
                                        'Plus Jakarta Sans',
                                        fontSize: 14*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5*ffem/fem,
                                        color: Color(0xff0c1c17),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // depth2frame1JHV (1:405)
                              width: 171*fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // depth3frame0dqZ (1:406)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                                    width: double.infinity,
                                    height: 56*fem,
                                    decoration: BoxDecoration (
                                      color: Color(0xffe0efea),
                                      borderRadius: BorderRadius.circular(12*fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${seconds.toString().padLeft(2, '0')}',
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
                                  ),
                                  Container(
                                    // secondshaX (1:413)
                                    margin: EdgeInsets.fromLTRB(0.23*fem, 0*fem, 0*fem, 0*fem),
                                    child: Text(
                                      'Seconds',
                                      style: SafeGoogleFont (
                                        'Plus Jakarta Sans',
                                        fontSize: 14*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5*ffem/fem,
                                        color: Color(0xff0c1c17),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // depth1frame71r7 (1:391)
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
      ),
          );
  }
}

class RequestWithSCC  extends StatelessWidget {
  final String courseCode;
  final String slot;
  final String code;

  RequestWithSCC({required this.courseCode, required this.slot, required this.code});
  @override
  Widget build(BuildContext context) {
    return RequestWithSCCSFC(courseCode: courseCode, slot: slot, code: code);
  }
}