import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientRecordStream extends StatefulWidget {
  PatientRecordStream({Key key}) : super(key: key);

  @override
  _PatientRecordStreamState createState() => _PatientRecordStreamState();
}

class _PatientRecordStreamState extends State<PatientRecordStream> {
  /*
  @override
  void initState() {
    super.initState();
    getData();
  } */

  /*
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<QuerySnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('gerdScaleOfPain')
        .where(firebaseUser.uid)
        .get();
  } */

  Future getMembers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection("gerdScaleOfPain").get();
    final documents = querySnapshot.docs;
    return documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Text(
                'Patient GERD Record',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            child: FutureBuilder<QuerySnapshot>(
                future: getMembers(),
                builder: (context, futureSnapshot) {
                  if (!futureSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  Map<String, String> users = {};
                  final userData = futureSnapshot.data.docs;
                  for (var user in userData) {
                    users[user.id] = user.get("Sets");
                  }
                }

                /*
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Icon(Icons.restaurant),
                              title: Text(
                                  //'${snapshot.data.docs[index].data()['Sets'][index]['Date'].toDate().toString()}'

                                  'error'),
                              subtitle: Text(
                                  //'${snapshot.data.docs[index].data()['Sets'][index]['Diet Plan'].toString()}\n${snapshot.data.docs[index].data()['Sets'][index]['Scale of Pain'].toString()}'
                                  'error'),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text("No data");
                } 
                return CircularProgressIndicator();
              },  */
                ),
          ),
        ],
      ),
    );
  }
}
