import 'package:flutter/material.dart';
import 'package:flutter_appwe/views/home.dart';
import 'package:flutter_appwe/views/signin.dart';

import 'helper/functions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedin = false;

  @override
  void initState(){
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus()async{
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedin = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (_isLoggedin ?? false) ? Home(): SignIn(),
    );
  }
}
