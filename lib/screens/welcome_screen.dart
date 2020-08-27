import 'package:chatting/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  //   التحكم في شكل الانميشن
  // اضافه انميشن يتغير بشكل مختلف بدل الشكل الافقي الافتراضي
  // اولا هنعرفه بالطريقه دي 
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
      //upperBound: 100.0   <=== لازم الابر باوند ميبقاش اكبر من واحد اصلا متحدد علي الجراف ف الموقع
    );

    // هنعمل تهيئه للكيرفد انيميشن لانها بتخلينا نستخدم اشكال كتير
    // . بتاخد قيمتين الاولي بيبق انميشن كونترولر
    // والتانيه نوع الكير اللي احنا عاوزين ننفذه
    // https://api.flutter.dev/flutter/animation/Curves-class.html.
    // معلومه كمان دا يعتبر طبقه هتتعرض فوق الكونترولر
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    
    controller.forward();

    controller.addListener(() {
      setState(() {});
      // الاستخدام بيتغير بنستخدم الشكل بدل الكونترولر
      print(animation.value);
    });

  }

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    // تغير الحجم
                    // الاستخدام بيتغير بنستخدم الشكل بدل الكونترولر
                    //  .التغير في الحجم من صفر لواحد مش هيبين حاجه لينا خالص خلينا نضربها في ميه
                    height: animation.value * 150,
                  ),
                ),
                Text(
                  'Chatting',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    setState(() {
                      Navigator.pushNamed(context,  LoginScreen.id);
                    });
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    setState(() {
                      Navigator.pushNamed(context,  RegistrationScreen.id);
                    });
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
