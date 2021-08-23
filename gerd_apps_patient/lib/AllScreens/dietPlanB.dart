import 'package:flutter/material.dart';
import 'package:gerd_apps/AllScreens/homeMenu.dart';

// firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerd_apps/Services/AuthenticationServices.dart';

import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'home_widget.dart';

class DietPlanB extends StatefulWidget {
  final User user;

  // pass id user
  DietPlanB({this.user});

  @override
  _DietPlanBState createState() => _DietPlanBState();
}

class _DietPlanBState extends State<DietPlanB> {
  //utk firebase
  final AuthenticationService _auth = AuthenticationService();

  // Utk currentUser;
  User currentUser = FirebaseAuth.instance.currentUser;

  //for patient to select The scale of GERD pain
  String title = 'DropDownButton';
  String _gerdpainVal;
  List _gerdpainScale = [
    'No Pain',
    'Minor Pain',
    'Moderate Pain',
    'Severe Pain'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      // Bahagian Atas
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          // button back to home menu
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomeWidget(),
              ),
            );
          },
        ),
      ),

      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text('DIET PLAN B', style: boldTextStyle()),
            Text(
              DateFormat("dd/MM/yyyy").format(DateTime.now()),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Display List Diet Plan B

            //bhgian kotak diet
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                              child: Image.asset(
                                'images/capati1.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer1(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),

            // 2
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                              child: Image.asset(
                                'images/ikanBakar.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer2(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),

            //3
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                              child: Image.asset(
                                'images/buburNasi1.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer3(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Text('Select your scale of GERD pain today',
                style: boldTextStyle()),

            // bhg select scale of  pain
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: DropdownButton(
                hint: Text(
                  'Select scale of pain',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                dropdownColor: Color(0xFF5FACC9),
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                isExpanded: true,
                value: _gerdpainVal,
                onChanged: (value) {
                  setState(() {
                    _gerdpainVal = value;
                  });
                },
                items: _gerdpainScale.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            // send data to firebase
            ElevatedButton(
              child: Text('UPDATED YOUR GERD TODAY'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                gerdPainUpdate(widget.user.uid);
                print(currentUser);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomeWidget(),
                  ),
                );
              },
            ),

            // Sent notiffication ke doctor
            /*ElevatedButton(
              child: Text('send notification'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                /*if (_formKey.currentState.validate()) {
                          createUser();
                        } */
              },
            ) */
          ],
        ),
      ),
    );
  }

  // Maklumat Diet Plan A
  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Breakfast",
            style: TextStyle(
                color: Color(0xFF5FACC9),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        //jarak ikut height
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                '8am - 10am \n Capati 1 Keping \n Pisang 1 Biji \n Susu ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
      ],
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Lunch",
            style: TextStyle(
                color: Color(0xFF5FACC9),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        //jarak ikut height
        SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                '12.30pm - 2pm \n Nasi Putih \n Ikan (Bakar/Kukus/Panggang) \n Tembikai 1 Potong \n Air Masak ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Dinner",
            style: TextStyle(
                color: Color(0xFF5FACC9),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "7.30pm - 10pm \n Bubur Nasi \n Kekacang \n Air Masak",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
      ],
    );
  }

  // function utk store data scaleofpain ke firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String timestamp;

  void gerdPainUpdate(String uid) async {
    await FirebaseFirestore.instance
        .collection('gerdScaleOfPain')
        .doc(uid)
        .set({
      'Sets': FieldValue.arrayUnion([
        {
          'Diet Plan': 'Diet Plan B',
          'Scale of Pain': _gerdpainVal,
          'Date': Timestamp.now(),
        }
      ])
    }, SetOptions(merge: true));
  }
}
