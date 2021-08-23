// simpan database
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileDoctor');

  // masukkan data patient dalam firebase cloud firestore
  Future<void> createUserData(
      String name, String email, String password, int phone, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    });
  }

  Future getUsersList() async {
    List itemsList = [];

    // getDocuments() change to get()
    // documents change to docs
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
    }
  }
}
