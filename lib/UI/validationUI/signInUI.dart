import 'package:bloc_firebase_validation/UI/validationUI/flarebackground.dart';
import 'package:bloc_firebase_validation/UI/validationUI/signInForm.dart';
import 'package:flutter/material.dart';


class signInUI extends StatefulWidget {
  @override
  _signInUIState createState() => _signInUIState();
}

class _signInUIState extends State<signInUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Dancing Script',
        color: Colors.white,

      ),),),
      backgroundColor: Colors.white,
      body: Stack(
        overflow: Overflow.visible,
        fit: StackFit.loose,
        children: <Widget>[
          flareBackground(),
          signInForm(30.0, 30.0)
        ],

      ),

    );
  }
}
