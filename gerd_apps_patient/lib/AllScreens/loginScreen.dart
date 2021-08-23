import 'package:flutter/material.dart';
import 'package:gerd_apps/AllScreens/registerScreen.dart';

//import auth firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerd_apps/Services/AuthenticationServices.dart';

class LoginScreen extends StatefulWidget {
  //navigation declare
  static const String idScreen = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _key = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  final AuthenticationService _auth = AuthenticationService();

  // declare data patient = name,email, password, weight, age, address
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 75.0,
              ),
              Image(
                image: AssetImage("images/logoGerd1.png"),
                width: 350.0,
                height: 250.0,
                alignment: Alignment.center,
              ),

              // text menandakan user sebagai patient/doctor
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Login as Patient",
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    //email
                    SizedBox(
                      height: 1.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    //password
                    SizedBox(
                      height: 1.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    // button login
                    SizedBox(
                      height: 15.0,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signInUser();
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // button pergi ke screen register
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/register', (route) => false);
                },
                child: Text("Don't have an account? Register Here."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //implement user to sign in

  void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailController.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. could not be able to login');
    } else {
      _emailController.clear();
      _passwordController.clear();
      // nanti tukar navigation kalau silap
      Navigator.pushNamed(context, '/navigationBottom');
    }
  }
}
