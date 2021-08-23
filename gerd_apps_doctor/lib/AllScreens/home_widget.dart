import 'package:flutter/material.dart';
import 'package:gerd_apps_doctor/AllScreens/testJadikeTak.dart/testPatientList.dart';
import 'package:gerd_apps_doctor/Services/AuthenticationServices.dart';

import 'dietPlan.dart';
import 'docProfile.dart';
import 'homeMenu.dart';
import 'testJadikeTak.dart/patientTableGerd.dart';
import 'testJadikeTak.dart/testPatientList1.dart';
import 'testPatientList2.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  // user login
  final AuthenticationService _auth = AuthenticationService();

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeMenu(),
    DietPlan(),
    DoctorProfile(),

    // test
    //ListPatientTest(),
    //ListPatientTest1(),
    //ListPatientTest2(),

    // test table patient
    //PatientTable(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bahagian Atas
      appBar: AppBar(
        title: Text('Gerd Monitoring'),
        automaticallyImplyLeading: false,

        //button utk logout
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut().then((result) {
                Navigator.of(context).pop(true);
              });
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
                //primary: Colors.purple,
                ),
          )
        ],
      ),

      //body
      body: _children[_currentIndex],
      // navigation bottom
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[800],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Diet Plan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
