import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatting/component/rounded_btn.dart';
import 'package:chatting/constants.dart';
// عاوز استخدم بروجرس بار يظهر والداتا بتحمل من النت
import 'package:modal_progress_hud/modal_progress_hud.dart';


import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registerScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
   String email;
  String password;
  // هعمل متغير قيمه افتراضيه انه يبق مخفي
  bool _showProgressSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // هخلي البدي بتاع الاسكافولد محاط بالاداه اللي انا لسا عاملها اكبورت في البب اسبيك دوت ياميل
      body: ModalProgressHUD(
        // احط قيمته الافتراضيه هنا انه يبق واقف
        inAsyncCall: _showProgressSpinner,
        child: Padding(
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
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                    password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
                RoundedButton(
                  btnName: 'Register',
                  btnColor: Colors.blueAccent,
                  onPressed:  () async{
                    // اول لما المستخدم يسجل دخول اظهرله الروجرس بار
                    setState(() {
                      _showProgressSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      // اول لما الداتا ترجع اخفيه تاني
                      setState(() {
                        _showProgressSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
