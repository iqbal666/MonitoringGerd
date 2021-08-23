import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientRecordStream1 extends StatefulWidget {
  PatientRecordStream1({Key key}) : super(key: key);

  @override
  _PatientRecordStream1State createState() => _PatientRecordStream1State();
}

// CurrentPakai
class _PatientRecordStream1State extends State<PatientRecordStream1> {
  @override
  void initState() {
    //getData();
    super.initState();
  }

  /*Future<QuerySnapshot> getData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      return await FirebaseFirestore.instance
          .collection('gerdScaleOfPain')
          .where(firebaseUser.uid)
          .get();
  } */

  //final firebaseUser = FirebaseAuth.instance.currentUser;

  //var uid = (await FirebaseAuth.instance.currentUser).uid;
  //var uid = (FirebaseAuth.instance.currentUser).uid;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots();

  /*Stream<QuerySnapshot> stream() async* {
    User currentUser = FirebaseAuth.instance.currentUser;
    var firestore = FirebaseFirestore.instance;
    var _stream =
        firestore.collection("profileInfo").where(currentUser.uid).snapshots();
    yield* _stream;
  } */

  /*CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('profileInfo');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  } */

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          return new ListView(children: getExpenseItems(snapshot));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((doc) => Card(
              child: new ListTile(
                  leading: Icon(Icons.restaurant),
                  title:
                      new Text(snapshot.data.docs[0]['Diet Plan'].toString()),
                  //snapshot.data.docs[index].get('Sets')[0]['Diet Plan']
                  subtitle: new Text(doc["email"])),
            ))
        .toList();
  }
}
/* return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot docs) {
                  return Card(
                    elevation: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Icon(Icons.restaurant),
                        title: docs['name'],

                        /*Text(
                            //'${snapshot.data.docs[index].get('Sets')[0]['Date'].toDate().toString()}',
                            //"error",
                            snapshot.data.docs[index].get('name'),
                          ), */
                        subtitle: docs['email'],
                        /*Text(
                            snapshot.data.docs[index].get('email'),
                          ), */
                      ),
                    ),
                  );
                }).toList(),
              );

              /*return ListView(children: snapshot.data.docChanges
                  .map<Widget>((DocumentSnapshot document) {
                return eventCard(
                    imageUrl: document['ImageUrl'],
                    title: document['Title'],
                    description: document['Description'],
                    venue: document['Venue'],
                    date: document['Date'],
                    time: document['Time']);
              })); */
            }));
  } */
