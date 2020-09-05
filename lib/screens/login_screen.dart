import 'package:flutter/material.dart';
import 'package:chatting/component/rounded_btn.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              // هنا فقط وبيكون متكرر لون النص اللي المستخدم بيكتبه
              style: TextStyle(color: Colors.lightBlueAccent),
              // كوبي وز بتخليني اعديل علي صفه معينه بعينها في حته محدده تخص القيم اللي انا نقلته كله
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email',),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              style: TextStyle(color: Colors.lightBlueAccent),
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
              RoundedButton(
                btnColor: Colors.lightBlueAccent,
                btnName: 'Log In',
                onPressed: (){

                },
              )
                  ],
        ),
      ),
    );
  }
}
