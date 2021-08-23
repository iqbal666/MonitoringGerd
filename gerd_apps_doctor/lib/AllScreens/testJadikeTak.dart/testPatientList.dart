import 'package:flutter/material.dart';

//firebase
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// pakai fifi punya coding flutter tapi dia guna realtime database tak jadi dan x faham
// failed : ikut tuto dari youtube tak jadi error null

DatabaseReference newgoPatrolRef =
    FirebaseDatabase.instance.reference().child("GoPatrol Requests");

final CollectionReference userGerdRef =
    FirebaseFirestore.instance.collection('gerdScaleOfPain');

class ListPatientTest extends StatefulWidget {
  //pass data
  ListPatientTest({Key key, this.timestamp}) : super(key: key);

  final String timestamp;

  @override
  _ListPatientTestState createState() => _ListPatientTestState();
}

/*
_getReq() {
  newgoPatrolRef.once().then((DataSnapshot snapshot) {
    setState(() {
      reqList = new Map<String, dynamic>.from(snapshot.value);
      reqKeys = reqList.keys.toList();
      print(reqList);
      requestList = reqList;
    });
    return [requestList];
  });
} */

/*
getGerdScale() {
  userGerdRef.once().then((DataSnapshot snapshot) {
    setState(() {
      gerdScaleList = new Map<String, dynamic>.from(snapshot.value);

      reqKeys = reqList.keys.toList();
      print(reqList);
      requestList = reqList;
    });
    return [requestList];
  });
} */

class _ListPatientTestState extends State<ListPatientTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                  /*
                width: double.infinity,
                child: requestList == null 
                    ? Container(
                        color: Colors.white,
                        child: Center(
                          child: SpinKitChasingDots(
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: requestList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index, reqList);
                        }), */
                  ),
            ],
          ),
        ),
      ),
    );

    /* failed
    return Container(
        //child: ListPage(),
        ); */
  }
}

/*
Widget buildList(BuildContext context, int index, snapshot) {
  int num = index + 1;
  dropOff = requestList[requestList.keys.elementAt(index)]['dropoff'];
  int dcount = dropOff.length;
  print(dropOff);

  if (requestList[requestList.keys.elementAt(index)]['req_person'] !=
      employee.firstName)
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: secondary),
                image: DecorationImage(
                    image: AssetImage('assets/images/taxi.png'),
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(height: 10.0),
            Text(num.toString()),
          ]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  requestList.keys.elementAt(index),
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 6,
                ),

                // nama detail
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                            "Starting Point: " +
                                officeList[requestList[
                                        requestList.keys.elementAt(index)]
                                    ['starting_point']]['name'],
                            style: TextStyle(
                                color: primary,
                                fontSize: 13,
                                letterSpacing: .3))),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                for (var i = 1; i < dcount; i++)
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Text(
                              "Drop Off: " + officeList[dropOff[i]]['name'],
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                  letterSpacing: .3))),
                    ],
                  ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.school,
                      color: secondary,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        "Request by:  " +
                            requestList[requestList.keys.elementAt(index)]
                                ['req_person'] +
                            "\n" +
                            requestList[requestList.keys.elementAt(index)]
                                ['req_person_phone'],
                        style: TextStyle(
                            color: primary, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                
              ],
            ),
          )
        ],
      ),
    );
} */

/* failed 

The method 'call' was called on null.
Receiver: null
Tried calling: call()
The relevant error-causing widget was
FutureBuilder<dynamic>
lib\AllScreens\testPatientList.dart:55

// interface tunjuk list patient yg daftar
class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  // utk future
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("gerdScaleOfPain").get();

    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data().length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // syntax updated
                    title: Text(snapshot.data[index].data()["timestamp"]),
                    //onTap: () => navigateToDetail(snapshot.data()[index]),
                  );
                },
              );
            }
          }),
    );
  }
}

// interface show information
class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: ListTile(
          //title: Text(widget.post.data["title"]),
          ),
    ));
  } 
} */
