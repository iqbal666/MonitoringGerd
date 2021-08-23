import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//firebase
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import other package
import 'package:gerd_apps_doctor/DatabaseManager/DatabaseManager.dart';

import 'home_widget.dart';

// code tarik data dari firestore ikut collection profilePatient
//ikut tutorial dari flutter firebase documentation
//guna streambuilder

class ListPatientTest2 extends StatefulWidget {
  ListPatientTest2({Key key}) : super(key: key);

  @override
  _ListPatientTest2State createState() => _ListPatientTest2State();
}

class _ListPatientTest2State extends State<ListPatientTest2> {
  /* cth date setting
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  String formattedDate(timestamp) {
    var format = new DateFormat('d MMM, hh:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }

  static convertTimeStamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }

  */

  //final Stream<QuerySnapshot> _usersStream =
  //    FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots();

  @override
  void initState() {
    _usersStream;
    super.initState();
  }

  final firebaseUser = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerd Monitoring'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          // button back to home menu
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (ctx) => HomeWidget(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // utk loop data berulang
                      int Listarray =
                          snapshot.data.docs[index].get('Sets').length;

                      print(snapshot.data.docs[index].id);
                      print(snapshot.data.docs[index].get('Sets').length);

                      return Card(
                        elevation: 1.5,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                for (var i = 0; i < Listarray; i++)
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //for (var i = 0; i < Listarray; i++)
                                        Container(
                                          child: Text(snapshot.data.docs[index]
                                              .get('Sets')[i]['Diet Plan']),

                                          //readTimestamp = (snapshot.data.docs[index].data()['Date']).toDate().toString())
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    160,
                                                child: new Text(
                                                  /*formattedDate(snapshot
                                                    .data.docs[index]
                                                    .data()['Sets'][index]['Date']),
                                                style: TextStyle(fontSize: 17), */

                                                  (snapshot.data.docs[index]
                                                      .get('Sets')[i]['Date']
                                                      .toDate()
                                                      .toString()),
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            new Text(snapshot.data.docs[index]
                                                    .get('Sets')[i]
                                                ['Scale of Pain']),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                              ],
                            )),
                      );
                    }); //.toList(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
