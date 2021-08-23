import 'package:flutter/material.dart';

//firebase
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import other package
import 'package:gerd_apps_doctor/DatabaseManager/DatabaseManager.dart';

//final CollectionReference usersRef =
//  FirebaseFirestore.instance.collection('gerdScaleOfPain');

//final documentID = userDocument.documentID;

// tak jadi iku tutorial youtube yg tarik dari DatabaseManager

class ListPatientTest1 extends StatefulWidget {
  ListPatientTest1({Key key}) : super(key: key);

  @override
  _ListPatientTest1State createState() => _ListPatientTest1State();
}

class _ListPatientTest1State extends State<ListPatientTest1> {
  List userProfilesList = [];

  @override
  void initState() {
    //getGerdScale();
    //getUserById();
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  /* failed
  // call list data dari firestore
  getGerdScale() async {
    usersRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data());
        // print(doc.documentID);
        print(doc.exists);
      });
    });
  } 

  // get users by id
  getUserById() {
    final String id = "u0UfmZZWjKU5RTAcNqBg7iO2Vxv1";
    usersRef.doc(id).get().then((DocumentSnapshot doc) {
      print(doc.data());
      //print(doc.documentID);
      print(doc.exists);
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(userProfilesList[index].data()['name']),
                      subtitle: Text(userProfilesList[index].data()['email']),
                      leading: CircleAvatar(
                        child: Image(
                          image: AssetImage('images/userprofile.png'),
                        ),
                      ),
                    ),
                  );
                })));
  }
}
