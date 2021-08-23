import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerd_apps_doctor/AllScreens/dietPlan.dart';
import 'package:gerd_apps_doctor/AllScreens/docProfile.dart';
import 'package:gerd_apps_doctor/AllScreens/home_widget.dart';
import 'package:gerd_apps_doctor/AllScreens/loginScreen.dart';
import 'package:gerd_apps_doctor/AllScreens/registerScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GERD Monitoring for Doctor',
      theme: ThemeData(
        // font family tukar
        //fontFamily: "Norwester",
        fontFamily: "NotoSansSC",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // start first page
      initialRoute: '/login',
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        // utk view
        //'/homeMenu': (context) => HomeMenu(),
        '/dietplan': (context) => DietPlan(),
        '/profile': (context) => DoctorProfile(),
        //utk destination login ke navigation
        '/navigationBottom': (context) => HomeWidget(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
