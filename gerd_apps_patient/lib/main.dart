import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerd_apps/AllScreens/loginScreen.dart';
import 'package:gerd_apps/AllScreens/registerScreen.dart';

import 'AllScreens/dietPlanA.dart';
import 'AllScreens/dietPlanB.dart';
import 'AllScreens/homeMenu.dart';
import 'AllScreens/profileScreen.dart';
import 'AllScreens/home_widget.dart';

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
      title: 'GERD Monitoring for Patient',
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
        '/homeMenu': (context) => HomeMenu(),
        '/dietplanA': (context) => DietPlanA(),
        '/dietplanB': (context) => DietPlanB(),
        '/profile': (context) => Profile(),
        //utk destination login ke navigation
        '/navigationBottom': (context) => HomeWidget(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
