import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatting/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
final _fireStore = FirebaseFirestore.instance;
// دا اليوزر اللي عمل لوجن وبيكتب حاليا
// حطيناه هنا علشان نقدر نوصله من اي مكان ف الملف دا
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
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
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
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

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot){
        List<MessageBubble> messageWidgets = [];
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs;
        for (var massage in messages) {

          final messageText = massage.data()['text'];
          // وللتذكره دا الاميل اللي مرفق مع الرساله لما اتبعتت
          final messageSender = massage.data()['sender'];

          // دا الاميل بتاع اليوزر اللي لسا مسجل دخول
          final currentUserEmail = loggedInUser.email;

          final messageWidget = MessageBubble(
            sender: messageSender,
            text: messageText,
            // بدل ما اعمل شرط يتحقق تساوي الاميلين وابعت الناتج منهم صح او خطا
            // بعمل هنا في نفس السطر
            // طب التحقق دا اصلا لازمته ان اخلي رسايل الشخص اللي مسجل دخول كلها يمين
            // واي رسايل جايه من اميله تاني تبق نحيه الشمال
            isMe: currentUserEmail == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
              children : messageWidgets
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {

  MessageBubble({this.sender, this.text, this.isMe});
  final String sender;
  final String text;
  // المتغير دا بيتسجل فيه صح لو الاميل اللي عامل لوجن بيساوي نفس الاميل اللي لسا مسجل دخول
  // طب ليه احنا محاجين نفرق ؟
  // علشان احنا هنفصل رسايل الشخص اللي لسا عامل لوجن عن اي رسايل تانيه مبعوته من شخص تاني
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),

      child: Column(
        // تغير اتجاه خلفيه الكلام بناء علي الايميل
      crossAxisAlignment:  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            // هنعدل الزوايا علشان يبق شكل الشات برسمه جميله
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),

            elevation: 4.0,
            // تغير لون خلفيه الكلام بناء علي الايميل
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 15.0,
                  // تغير لون الكلام بناء علي الايميل
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

