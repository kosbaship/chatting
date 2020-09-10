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

  // void getMessages() async {
  //   final messg = await _fireStore.collection('messages').get();
  //   for (var message in messg.docs){
  //     print(message.data());
  //   }
  // }

  // هستخدمها علشان اتصنت علي الرسايل اللي جايه من الفير بيز
  void messageStreams() async{
    // داله الاسناب شوت دي بتتصنط علي اللي بيحصل ف الكولكشن دا
    //  احنا ممكن نتخيل الاستريمات دي كانها قايمه فا احنا هنلف جوا القايمه اللي كل شويه تتجدد دي
    await for (var snapshot in _fireStore.collection('messages').snapshots() ){
      // هنا بق انا بقلب جوه القايمه علشان اعرض كل ايتم جواها
      // طبعا للتذكره القايمه دي بيضاف عليها اي ايتم جديد بيتحط ف الفاير استور
        for (var message in snapshot.docs){
          print(message.data());
        }
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
                messageStreams();
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
