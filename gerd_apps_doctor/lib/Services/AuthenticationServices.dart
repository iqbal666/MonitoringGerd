// untuk authen login dan register user
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerd_apps_doctor/DatabaseManager/DatabaseManager.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

// registration doctor anonymous with email and password
  Future createNewUser(
      String email, String password, String name, int phone) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // error userCredential.user change to userCredential.user!
      User user = userCredential.user;
      await DatabaseManager()
          .createUserData(name, email, password, phone, user.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

// sign with email and password
  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

// user signout from the apps
  Future signOut() async {
    try {
      return FirebaseAuth.instance.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
