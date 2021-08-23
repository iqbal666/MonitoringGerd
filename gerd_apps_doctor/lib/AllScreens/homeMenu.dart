import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerd_apps_doctor/AllScreens/testPatientList2.dart';
import 'package:intl/intl.dart';

import 'testJadikeTak.dart/patientTableGerd.dart';

String uid;

// tarik data dari firestore
final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('profileInfo').snapshots();

class HomeMenu extends StatefulWidget {
  HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
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

  // declare name utk display name dari cloud firestore
  String name = "";

  // navigate to PatientTable()
  navigateToDetail(QuerySnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientTable(
                /* post : post, */
                )));
  }

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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Patient',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // section show patient
                    Flexible(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _usersStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              return new ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new GestureDetector(
                                        //onTap: () => print([index]),
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListPatientTest2()
                                                  //PatientTable()

                                                  ));
                                          /*onTap: () => {
                                                    //navigateToDetail(),
                                                    print(document.id),
                                                    print(data['name'])  */
                                        },
                                        child: new Card(
                                          elevation: 1.5,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: ListTile(
                                                title: Row(
                                                  children: <Widget>[
                                                    //gambar
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          //color: Color(0xFF5FACC9),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      60 / 2),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                  'images/userprofile.png'))),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                175,
                                                            child: new Text(
                                                              snapshot.data
                                                                          .docs[
                                                                      index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  fontSize: 17),
                                                            ),
                                                            //title: Text(snapshot.data[index].data()["timestamp"]),
                                                            //onTap: () => navigateToDetail(data['name']),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          // email
                                                          //new Text(data['email']),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          // passing data
                                                          /*GestureDetector(
                                                    onTap: () async {
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              //ListPatientTest2
                                                              PatientTable())); */
                                                          /*onTap: () => {
                                                    //navigateToDetail(),
                                                    print(document.id),
                                                    print(data['name']) 
                                                  }, */

                                                          Text(
                                                              'Daily Record GERD Symptoms',
                                                              style: TextStyle(
                                                                  fontSize: 15))
                                                        ])
                                                  ],
                                                ),
                                              )),
                                        ));
                                  });
                            }) //.toList(),
                        )
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  // dapatkan maklumat user login dari cloud firestore tanpa instance dari DatabaseManager.dart
  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('profileDoctor')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        // error ds.data() change to ds.data()!
        name = ds.data()['name'];
        print(name);
      }).catchError((e) {
        print(e);
      });
  }
}

/*
Widget ListBuild() {
  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return new ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          return Card(
            elevation: 1.5,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            //color: Color(0xFF5FACC9),
                            borderRadius: BorderRadius.circular(60 / 2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/userprofile.png'))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 140,
                              child: new Text(
                                data['name'],
                                style: TextStyle(fontSize: 17),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          new Text(data['email']),
                        ],
                      )
                    ],
                  ),
                )),
          );
        }).toList(),
      );
    },
  );
} */
