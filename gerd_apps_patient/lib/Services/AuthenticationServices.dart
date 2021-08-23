// untuk authen login dan register user
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerd_apps/DatabaseManager/DatabaseManager.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User loggedInUser;

// registration anonymous with email and password
  Future createNewUser(String email, String password, String name, int weight,
      int age, String address) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await DatabaseManager().createUserData(
          name, email, password, weight, age, address, user.uid);
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

  // CurrentUser
  /*
  Future<User> getCurrentUser() async {
    User user = await FirebaseAuth
  } */

  /* void getCurrentUser() async {
    try {
      User user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
          //print('this is:  ${loggedInUser.email}');
        });
      }
    } catch (e) {
      print(e);
    }
  } */

  /*
  // Get current user login detail Uid
  Future<void> getCurrentUser() async {
    final User user = auth.currentUser;
    setState(() {
      userProfile = user.displayName;
    });
  } */

  /*
  Future<void> getCurrentUserData() async{
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String  firstname = ds.get('name');
      String lastname = ds.get('LastName');
      return [firstname,lastname];
    }catch(e){
      print(e.toString());
      return null;
    }
  } */

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
