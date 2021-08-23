import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientRecordStream extends StatefulWidget {
  PatientRecordStream({Key key}) : super(key: key);

  @override
  _PatientRecordStreamState createState() => _PatientRecordStreamState();
}

// CurrentPakai
class _PatientRecordStreamState extends State<PatientRecordStream> {
  @override
  void initState() {
    _usersStream;
    super.initState();
  }

  final firebaseUser = FirebaseAuth.instance.currentUser;

  //declare nama file database
  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: _usersStream,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return new ListView.builder(
                  //itemCount: courseDocument != null ? courseDocument.length : 0,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // utk loop data berulang
                    int Listarray =
                        snapshot.data.docs[index].get('Sets').length;

                    print(snapshot.data.docs[index].id);
                    print(snapshot.data.docs[index].get('Sets').length);

                    //filter bg dapatkan current user uid
                    return snapshot.data.docs[index].id == firebaseUser.uid
                        ? Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                for (var i = 0; i < Listarray; i++)
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.restaurant),
                                          title: Text(
                                              //"Date :" + [Listarray][i]['Diet Plan'],
                                              snapshot.data.docs[index]
                                                  .get('Sets')[i]['Date']
                                                  .toDate()
                                                  .toString()),
                                          subtitle: new Text(
                                              '${snapshot.data.docs[index].get('Sets')[i]['Diet Plan']}\n${snapshot.data.docs[index].get('Sets')[i]['Scale of Pain']}'
                                              //snapshot.data.docs[index].get('Sets')[0]['Scale of Pain']
                                              //{item[index]['schedule_day']}
                                              ),
                                        ),
                                      ])
                              ],
                            ),
                          )
                        : Container();
                  });

              if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
