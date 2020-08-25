import 'package:chatting/screens/chat_screen.dart';
import 'package:chatting/screens/login_screen.dart';
import 'package:chatting/screens/registration_screen.dart';
import 'package:chatting/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
home: WelcomeScreen(),
//      // هعمل الاتجهات بتاعتي
//      initialRoute: '/',
//      routes: {
//        '/': (context) => WelcomeScreen(),
//        '/login': (context) => LoginScreen(),
//        '/register': (context) => RegistrationScreen(),
//        '/chat': (context) => ChatScreen(),
//      },
    );
  }
}
