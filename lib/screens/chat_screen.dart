import 'package:flutter/material.dart';
import 'package:chatting/constants.dart';
//بردو هعمل امبورت للاوثنتكيشن
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth = FirebaseAuth.instance;
  // الاول كانت فايربيس يوزر اتغيرت بق كدا واوث ريزلت بردو بقت يوزر كريدنشيل
  User loggedInUser;

  // هنوصل لليوزر دا اول ما نفتح البرنامج
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // هنعمل داله دورها انها تشوف هل في يوزر حالي عمل تسجيل دخول ولا لاء
  void getCurrentUser() {
    // هنا بق نستقبل اليوزر اللي سجل دخول
    // طبعا لازم هيرجع فيوتر لانها هتاخد وقت علي ما تيجي ف هنامن نفسنا
    try {
      final user = _auth.currentUser;
      if (user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
