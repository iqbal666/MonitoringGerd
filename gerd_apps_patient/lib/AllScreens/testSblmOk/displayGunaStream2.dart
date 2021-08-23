import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DisplayStream2 extends StatefulWidget {
  DisplayStream2({Key key}) : super(key: key);

  @override
  _DisplayStream2State createState() => _DisplayStream2State();
}

// ERROR The method 'get' was called on null. Receiver: null Tried calling: get("Sets")

class _DisplayStream2State extends State<DisplayStream2> {
  @override
  void initState() {
    //getData();
    //_usersStream;
    //stream();
    super.initState();
  }

  final firebaseUser = FirebaseAuth.instance.currentUser;

  /*Future<QuerySnapshot> getData() async { 
      return await FirebaseFirestore.instance
          .collection('gerdScaleOfPain')
          .where(firebaseUser.uid)
          .get();
  } */

  //var uid = FirebaseAuth.instance.currentUser;

  /*Stream<QuerySnapshot> stream() async* {
    User currentUser = FirebaseAuth.instance.currentUser;
    var firestore = FirebaseFirestore.instance;
    var _stream = firestore
        .collection("gerdScaleOfPain")
        .where(currentUser.uid)
        .snapshots();
    yield* _stream;
  } */

  /*final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots(); */

  Stream<DocumentSnapshot> getData1() async* {
    User user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('gerdScaleOfPain')
        .where("userId", isEqualTo: user.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            //future: getData(),
            //stream: _usersStream,
            stream: getData1(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              var courseDocument = snapshot.data.get('Sets');

              //var sections = courseDocument()['Sets'];

              return ListView.builder(
                  itemCount: courseDocument != null ? courseDocument.length : 0,
                  //itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Icon(Icons.restaurant),
                          title:

                              //Text(snapshot.data.docs[index].get('Sets')[0]
                              //  ['Diet Plan']),
                              Text(courseDocument[index]['Diet Plan']),

                          //snapshot.data[index].data()["arrayData"][index]["doOne"].toString(),

                          //subtitle: new Text(snapshot.data.docs[index]
                          //  .get('Sets')[0]['Scale of Pain']),

                          //'${snapshot.data.docs[index].get('Sets')[0]['Diet Plan']}\n${snapshot.data.docs[index].get('Sets')[0]['Scale of Pain']}',
                        ),
                      ),
                    );
                  });

              if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            }));
  }
}
