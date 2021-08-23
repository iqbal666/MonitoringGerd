import 'package:flutter/material.dart';

// firebase import
import 'package:gerd_apps/Services/AuthenticationServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* display data pakai streambuilder tak jadi
final firebaseUser = FirebaseAuth.instance.currentUser;

Stream<DocumentSnapshot> courseDocStream = FirebaseFirestore.instance
    .collection('profileInfo')
    .doc(firebaseUser.uid)
    .snapshots();

*/

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthenticationService _auth = AuthenticationService();

  // declare name utk display name dari cloud firestore
  String name;
  String email;
  int age;
  int weight;
  String address;

  Widget build(BuildContext context) {
    return Scaffold(
        // Bahagian Atas

        // body utk profile
        body: new Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: 250.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: new Stack(fit: StackFit.loose, children: <
                                Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // image profile
                                  new Container(
                                      // size image bulat
                                      width: 140.0,
                                      height: 140.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: new ExactAssetImage(
                                              'images/userprofile.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ],
                              ),
                              // camera merah
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 90.0, right: 100.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),

                    // patient profile information
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // text - personal information
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Patient Profile Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    //
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        //_status ? _getEditIcon() : new Container(),
                                      ],
                                    )
                                  ],
                                )),
                            // Text papar nama patient
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Patient Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text("Loading data");
                                            return Text(
                                              "$name",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          }),

                                      /* new TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Patient Name",
                                        ),
                                      ), */
                                    ),
                                  ],
                                )),

                            // Text papar email patient
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Patient Email',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text("Loading data");
                                            return Text(
                                              "$email",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                )),

                            // Text papar nombor patient
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Patient Age',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text("Loading data");
                                            return Text(
                                              "$age",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          }),

                                      /* new TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Patient Name",
                                        ),
                                      ), */
                                    ),
                                  ],
                                )),

                            // Text papar weight patient
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Patient Weight(kg)',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text("Loading data");
                                            return Text(
                                              "$weight",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          }),

                                      /* new TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Patient Name",
                                        ),
                                      ), */
                                    ),
                                  ],
                                )),

                            // Text papar address patient
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Patient Address',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text("Loading data");
                                            return Text(
                                              "$address",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          }),

                                      /* new TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Patient Name",
                                        ),
                                      ), */
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],

              // User Profile
            )));
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
        email = ds.data()['email'];
        age = ds.data()['age'];
        weight = ds.data()['weight'];
        address = ds.data()['address'];
        print(name);
        print(age);
        print(weight);
        print(address);
      }).catchError((e) {
        print(e);
      });
  }
}
