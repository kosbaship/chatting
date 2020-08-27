import 'package:chatting/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// هنضيف السطر دا للولكم اسكرين علشان ياكت كا تكر بروفايدر (التكه هيا قلبه الصفحه ف الفليب بوك)
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

   // هنعرف الانميشن كونترولر
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    // هنعمل التهيئه بتاعته انه يتبني اول ما الاستات اوبجكت بتعنا يتبني
    //  بشكل افتراضي الكونرولر دا هيحرك رقم والرقم دا بيزيد مع كل تكه
    //  والرقم دا بيبق في مدي بين صفر لواحد 0.01
    //  وطبعا في الثانيه الواحده هنلاقي ٦٠ تكه في التكير بتاعنا بمعني
    //  تاني الكونترولر بتاعنا هيتحرك من ٠ لواحده في ٦٠ خطوه
    controller = AnimationController(
      //الانميشن دا هيعد وقت قد ايه
      duration: Duration(seconds: 1),
      // دي المكان اللي بنحط فيه التيكر بروفايدر وفي حالتنا هنا
      // احنا هنستخدم الكلاس بتاعنا (ستات اوبجكت) كتيكر بوفايدر
      vsync: this,    // دي الوحيده المطلوبه بشكل اجباري علشان يحدد ايه اللي هيبق تكر ======>
    );

    //كدا نخلي الانميشن يبدا
    //دي هتخلي الانميش يكمل
    controller.forward();

    // هنضيف مستمع للكونرولر علشان نشوف هو بيعمل ايه
    // معلومه تخص الليسنر انه بياخد جواه كول باك
    controller.addListener(() {
      // دي هنضيفها علشان خاطر نخلي فلاتر تتفاعل مع القيمه اللي بتتغير
      // وانها تعد تبني الاسكرين من اول جديد
      setState(() {
        // احنا سايبنها فاضيه لان القيمه بتاعتنا بالفعل بتتغير جوه الانميشن كونترولر
      });
      // هنا احنا ممكن نتصنت علي القيمه اللي جوه الكونرولر
      print(controller.value);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // هنا انا ممكن استخدم القيمه اللي جوه الكونرولر دا علشان اغير بيها حاجه مثال
      backgroundColor: Colors.white.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // بدايه صنع هيرو انيميشن
                // اضافه الاداه المشتركه هنا في البدايه
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
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
