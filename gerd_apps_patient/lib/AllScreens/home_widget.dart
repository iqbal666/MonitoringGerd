import 'package:flutter/material.dart';
import 'package:gerd_apps/AllScreens/displayGunaFuture.dart';
import 'package:gerd_apps/Services/AuthenticationServices.dart';
import 'dietPlanA.dart';
import 'homeMenu.dart';
import 'testSblmOk/displayGunaStream1.dart';
import 'displayGunaStream.dart';
import 'testSblmOk/displayGunaStream2.dart';
import 'testSblmOk/patientGerdRecord.dart';
import 'profileScreen.dart';

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

    // Yang guna sekarang utk display data pakai FutureBuilder dan StreamBuilder
    //PatientRecordFuture(),
    PatientRecordStream(),

    // test view utk streambuilder bg current user dgn map of array
    //PatientRecordStream1(),
    //DisplayStream2(),

    //DietPlanA(),
    //PatientRecord(),

    Profile(),
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
        title: Text('Home'),
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
          selectedItemColor: Color(0xFF5FACC9),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.addchart),
              label: 'Patient Record',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
