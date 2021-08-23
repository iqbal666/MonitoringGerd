import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientRecordFuture extends StatefulWidget {
  PatientRecordFuture({Key key}) : super(key: key);

  @override
  _PatientRecordFutureState createState() => _PatientRecordFutureState();
}

// CurrentPakai
class _PatientRecordFutureState extends State<PatientRecordFuture> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<QuerySnapshot> getData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      return await FirebaseFirestore.instance
          .collection('gerdScaleOfPain')
          .where(firebaseUser.uid)
          .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
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
                              '${snapshot.data.docs[index].get('Sets')[0]['Date'].toDate().toString()}',
                            ),
                            subtitle: Text(
                              '${snapshot.data.docs[index].get('Sets')[0]['Diet Plan']}\n${snapshot.data.docs[index].get('Sets')[0]['Scale of Pain']}',
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            }));
  }
}
