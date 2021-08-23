//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerd_apps/AllScreens/dietPlanA.dart';
import 'package:intl/intl.dart';

import 'package:gerd_apps/Services/AuthenticationServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerd_apps/DatabaseManager/DatabaseManager.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants.dart';
import 'dietPlanB.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class HomeMenu extends StatefulWidget {
  HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  // user login
  final AuthenticationService _auth = AuthenticationService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  // declare untuk currentUser
  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    /*
    try {
      auth.currentUser().then((userId) { //I've removed the 'widget.'
        setState(() {
          authStatus =
              userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
      });
    } catch (e) {} */
  }

  /*
  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  } */

  // declare name utk display name dari cloud firestore
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF5FACC9),

        // Bahagian Atas

        // Body
        body: Container(
          margin: EdgeInsets.only(top: 8),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //gambar user
                        Container(
                          height: 80,
                          width: 59,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage('images/userprofile.png'))),
                        ),

                        SizedBox(
                          width: 16,
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // display current date
                            Text(
                              DateFormat("dd/MM/yyyy").format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              'Hi, Welcome',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        //jarak antara column
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Card Section
              SizedBox(
                height: 1,
              ),

              Divider(
                color: Colors.black38,
                thickness: 1,
              ),

              // welcome dgn nama user

              Padding(
                padding: EdgeInsets.only(left: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                        future: _fetch(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("Loading data");
                          return Text(
                            "$name",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }),
                  ],
                ),
              ),

              // guna sizedbox utk jarakkan antara 2 object
              SizedBox(
                height: 30,
              ),

              // user choose diet plan
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Choose Your Diet Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        // section pilih diet plan
                        Container(
                          // width: size.width * 0.4,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  //diet plan A
                                  Card(
                                    //kotak diet plan
                                    child: Container(
                                      height: 250,
                                      width: 165,
                                      color: Colors.blue,
                                      child: Column(
                                        //kotak gamba diet plan
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (ctx) => DietPlanA(
                                                      user: currentUser),
                                                ),
                                              );
                                            },
                                            child: Container(
                                                height: 190,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/dietPlanA.png")),
                                                  //color: Colors.blueGrey,
                                                )),
                                          ),
                                          Text(
                                            "Diet Plan A",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  // diet Plan B
                                  Card(
                                    //kotak diet plan
                                    child: Container(
                                      height: 250,
                                      width: 165,
                                      color: Colors.blue,
                                      child: Column(
                                        //kotak gamba diet plan
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (ctx) => DietPlanB(
                                                      user: currentUser),
                                                ),
                                              );
                                            },
                                            child: Container(
                                                height: 190,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "images/dietPlanB.png")),
                                                  //color: Colors.blueGrey,
                                                )),
                                          ),
                                          Text(
                                            "Diet Plan B",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /*.onInkTap(() {
                    Get.to(CarDetailPage(
                      name: ds['name'],
                      model: ds['model'],
                    )); 
                  }) */
                      ]),
                ),
              )
            ],
          ),
        ));

    /* @override
    Widget build(BuildContext context) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return Text("Full Name: ${data['name']} ${data['address']}");
          }

          return Text("loading");
        },
      );
    } */
  }

  // dapatkan maklumat user login dari cloud firestore tanpa instance dari DatabaseManager.dart
  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('profileInfo')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        name = ds.data()['name'];
        print(name);
      }).catchError((e) {
        print(e);
      });
  }
}
