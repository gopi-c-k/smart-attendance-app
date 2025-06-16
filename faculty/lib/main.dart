import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/faculty-log-in.dart';
//import 'package:myapp/page-1/faculty-main-portal.dart';
//import 'package:myapp/page-1/student-details-who-attended-class.dart';
//import 'package:myapp/page-1/attendence-release-option.dart';
//import 'package:myapp/page-1/request-with-scc.dart';
import 'package:myapp/page-1/final-attendees-details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
	return MaterialApp(
		title: 'Flutter',
		debugShowCheckedModeBanner: false,
		scrollBehavior: MyCustomScrollBehavior(),
		theme: ThemeData(
		primarySwatch: Colors.blue,
		),
		home: Scaffold(
		body: SingleChildScrollView(
			child: FacultyLogin(),
     // child: FinalAttendeesDetails(attend: ["22MIS0058","22MIS0014"],cc: 'MAT2002'),
		),
		),
	);
	}
}
