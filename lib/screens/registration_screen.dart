import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatting/component/rounded_btn.dart';
import 'package:chatting/constants.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registerScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // عمل firebase authentication
  // هنعرف انستنس منه الكلاس
  final _auth = FirebaseAuth.instance;
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
                onPressed:  () async{
                  // ههندل اي ايرور يخص المصادقه ف هحط تراي وكاتش
                  try {
                    //  عمل رجيستر لليوزر بالاميل والباسورد (دا للمصادقه)
                    // وبما انه هيرجع فيوتشر هنحفظه ف المتغير دا علشان نستخدمه بعدين لما يخص المصادقه
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    // اتاكد ان كل حاجه تمام علشان تعمل الخطوه اللي بعد كدا
                    if (newUser != null) {
                      // روح بق الاسكرين اللي هناك استقبل اليوزر
                      //  هو اصلا المصادقه لو حصلت النيو يوزر
                      //  دل هيتسجل في _auth علي انه  CurrentUser بمعني ان حد سجل دخول
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
