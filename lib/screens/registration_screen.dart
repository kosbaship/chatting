import 'package:flutter/material.dart';
import 'package:chatting/component/rounded_btn.dart';
import 'package:chatting/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registerScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // استقبل بيانات من المستخدم
  // هنعمل لكل تكست فيد متغير
  String email;
  String password;


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
              // خلي التكست يظهر ف النص
              textAlign: TextAlign.center,
              // خلي الكيبورد يبق بنفس نوق الدادا اللي هستقبلها
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                // دي القيمه اللي جوه فيلد الاميل
                email = value;
                },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              // خلي الباسورد يبق محخفي
              obscureText: true,
              // خلي التكست يظهر ف النص
              textAlign: TextAlign.center,
              onChanged: (value) {
                // دي القيمه اللي جوا فيلد الباسورد
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
                onPressed: (){
                  // لما يضخط علي تسجيل اعرض القيمه ف اللوج
                  print(email);
                  print(password);
                },
              )
          ],
        ),
      ),
    );
  }
}
