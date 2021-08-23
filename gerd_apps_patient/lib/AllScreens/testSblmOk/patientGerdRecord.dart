import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientRecord extends StatefulWidget {
  PatientRecord({Key key}) : super(key: key);

  @override
  _PatientRecordState createState() => _PatientRecordState();
}

class _PatientRecordState extends State<PatientRecord> {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  //final Stream<QuerySnapshot> _usersStream =
  //    FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots();

  //Future _getData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<DocumentSnapshot>> getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("gerdScaleOfPain")
        .where(firebaseUser.uid)
        .get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: FutureBuilder(
              future: getData(),
              builder:
                  (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return new ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                          borderRadius:
                                              BorderRadius.circular(60 / 2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'images/dietPlanA.png'))),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                140,
                                            child: new Text(
                                              /*snapshot.data[index]
                                                      .data()["Sets"][index]
                                                  ["Diet Plan"], */

                                              'error',
                                              style: TextStyle(fontSize: 17),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          /* snapshot.data[index].data()["Sets"]
                                            [index]["Scale of Pain"] */
                                          'error',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        );
                      });
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text("No data");
                }
                return CircularProgressIndicator();
              }

              //.toList(),

              ),
        ),
      ],
    );
  }
}
