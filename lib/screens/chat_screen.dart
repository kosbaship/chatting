import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatting/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null){
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // هعمل داله تجبلي الداتا (الرسايل) من الفاير استور
  void getMessages() async {
    // هحدد الكولكشن اللي انا عاوز اجيب منه الداتا
    // السطر اللي جاي دا كاني ماسك كل الداتا اللي ف لكولكشن دا ف ايدي
    final messg = await _fireStore.collection('messages').get();
    // السطر اللي جاي دا هيجبلي ليسته من الدوكيونتس اللي هو العمود اللي ف النص ف الداتا بيز لو رحت اتفرج
    // بما انها ليسته وانا عاوز اجيب منا حاجه محدده هستخدم فور لوب
    for (var message in messg.docs){
      // كل مسدج جوه الليسته دي عباره عن رساله واحده فقط
      // الرساله مكونه من مرسل ونص
      //الداتا دي هتجبلنا المفتاح والقيمه يعني مثلا كلمه سندر والقيمه بتاعتها
      print(message.data());
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
                // حطتها هنا من اجل التجربه فقط
                getMessages();
                // _auth.signOut();
                // Navigator.pop(context);
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
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email
                      });
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
