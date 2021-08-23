// simpan database
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:gerd_apps/AllScreens/profileScreen.dart';

class DatabaseManager {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');

  // masukkan data patient dalam firebase cloud firestore
  Future<void> createUserData(String name, String email, String password,
      int weight, int age, String address, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'weight': weight,
      'age': age,
      'address': address,
    });
  }

  /*
  Future<void> addGerdStatus(
    String 
  ) */

  /*
  Future<String> getCurrentUser() async {
    String _email = (await FirebaseAuth.instance.currentUser()).email;
    return await _firestore
        .collection('users')
        .document(_email)
        .collection('met_with')
        .document('email')
        .get();
  } */

  /*
  Future updateUserList(
      String name, String gender, int score, String uid) async {
    return await profileList
        .document(uid)
        .updateData({'name': name, 'gender': gender, 'score': score});
  } */

  // fetch data user patient dari firebase utk display ke dlm apps guna getUserList
  /* Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    } */

  /*
    profileList.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    }); */

}

/* store patient data by map
// masukkan data patient dalam firebase cloud firestore
  Future<void> createUserData(String name, String email, String password,
      int weight, int age, String address, String uid) async {
    return await profileList.doc(uid).set({
      'patientProfile': {
        'name': name,
        'email': email,
        'password': password,
        'weight': weight,
        'age': age,
        'address': address,
      }
    });
  }
*/
