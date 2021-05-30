import 'package:flutter/material.dart';
import 'package:flutter_appwe/helper/functions.dart';
import 'package:flutter_appwe/services/auth.dart';
import 'package:flutter_appwe/views/home.dart';
import 'package:flutter_appwe/views/signin.dart';
import 'package:flutter_appwe/widgets/widgets.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signup() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      authService.signInEmailAndPass(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.savedUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter Name" : null;
                        },
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (val) {
                          name = val;
                        },
                      ),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter Email" : null;
                        },
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.isEmpty ? "Enter Password" : null;
                        },
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          signup();
                        },
                        child: blueButton(context:context,
                          label: "Sign Up",),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: TextStyle(fontSize: 15.5),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 15.5,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
