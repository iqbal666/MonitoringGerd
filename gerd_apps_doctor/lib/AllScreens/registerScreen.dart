import 'package:flutter/material.dart';

//import auth firebase

import 'package:gerd_apps_doctor/Services/AuthenticationServices.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    //final FormState form = _formKey.currentState;
    final FormState form = _formKey.currentState;
    // form form change to form!
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  final AuthenticationService _auth = AuthenticationService();

  // declare data patient = name,email, password, weight, age, address
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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

              //logo apps

              // text menandakan user sebagai patient/doctor
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Register as a Doctor",
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
                      validator: (value) =>
                          // error value change to value!
                          value.isEmpty ? 'Email cannot be blank' : null,
                      /* validator: (value) {
                        if (value.isEmpty) {
                          return 'Email cannot be empty';
                        } else
                          return null;
                      }, */
                      keyboardType: TextInputType.emailAddress,
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) =>
                          // error value change to value!
                          value.isEmpty ? 'Password cannot be blank' : null,
                      /* validator: (value) {
                        if (value.isEmpty) {
                          return 'Password cannot be empty';
                        } else
                          return null;
                      }, */
                      obscureText: true,
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

                    //Doctor name
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) =>
                          // error value change to value!
                          value.isEmpty ? 'Name cannot be blank' : null,
                      /* validator: (value) {
                        if (value.isEmpty) {
                          return 'Name cannot be empty';
                        } else
                          return null;
                      }, */
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Name",
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

                    //Doctor Phone Number
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) =>
                          // error value change to value!
                          value.isEmpty ? 'Phone Number cannot be blank' : null,
                      /* validator: (value) {
                        if (value.isEmpty) {
                          return 'Name cannot be empty';
                        } else
                          return null;
                      }, */
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
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

                    // button register
                    SizedBox(
                      height: 50,
                    ),

                    // button register new user
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        // error currentState change to currentState!
                        if (_formKey.currentState.validate()) {
                          createUser();
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Registered",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // button route ke login page
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                child: Text("Already have an account? LOG IN."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //implement create new user

  void createUser() async {
    dynamic result = await _auth.createNewUser(
      _emailController.text,
      _passwordController.text,
      _nameController.text,
      // kena parse string ke int & simpan dalam db firebase
      int.parse(_phoneController.text),
    );

    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      _passwordController.clear();
      _emailController.clear();
      _nameController.clear();
      // simpan dalam db firebase
      _phoneController.clear();

      // Dia navigate ke login page
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
