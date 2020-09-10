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
            // الاداه دي هتحول ليسته الاسناب شوت اللي عندنا لاداه فلاتر كل مره هيجي فيها داتا
            // هيتعملها اعاده بناء كل مره في داتا بتيجي من الاستريم وبتعمل دا عن طريق ال ست استات
            // نوع الداتا اللي حطيته هنا انا حطيته شبه الاسناب شت اللي تخص الفاير بيز
            StreamBuilder<QuerySnapshot>(
              //له قيمتين مهمين الاوليني هو الاستريم بمعني اخر الداتا جايه منين
              // داله الاسناب شوت دي (تخص فاير بيز) بتتصنط علي اللي بيحصل ف الكولكشن دا
            stream: _fireStore.collection('messages').snapshots(),
              // التاني با البلدر وهو المنطق للي الاستريم هيتبعه
              //  الأي سينك سناب شوت بيمثل اخر تفاعل حصل علي الاستريم
              // القيمه التانيه ف البلد دا هي الاسناب شوت اللي هترجع ليا
              // داله الاسناب شوت دي (تخص فلاتر بس هستخدم معاها دوال الفاير بيز) بتتصنط علي اللي بيحصل ف الكولكشن دا
              builder: (context, snapshot){
                // بما اني هعرض الداتا بشكل بدائي في عمود
                // هخلي كل عنصر ف الليسته دي عباره عن رساله
                // طبعا هملاها من خلال اللوب
                List<Text> messageWidgets = [];
                if(snapshot.hasData){
                  // دي الطريقه اللي بنوصل بيها للداتا جوه الاسناب شوت بتاعتنا
                  //snapshot دا من الاستريم بيلدي
                  //data دا من الفاير بيز
                  //docs دي ليسته من الاسناب شوت اللي بيكون جواها دايرك الرسايل بتاعتنا
                  // كل دا متعدل ومتزبط علشان نوع الداتا اللي حطيته انا ف الاستيرم بيلدر من البدايه
                  final messages = snapshot.data.docs;
                  // هتجيب العناصر من ليسته الراسايل اللي انا جايبه من الفاير بيز
                  // وتحط كل عنصر في اليسته اللي فوق دي بالترتيب علشان نعرضها للمستخدم
                  for (var massage in messages) {

                    // كل عنصر ف الليسته اللي جايه ف الفاير بيز عباره عن ماب
                    // مكون من مفتاح وقيمه هحط المفاتح علشان اخد القيمه
                    final messageText = massage.data()['text'];
                    final messageSender = massage.data()['sender'];

                    // دي الطريقه اللي هيتعرض بيها العنصر جوه القايمه
                    final messageWidget = Text('$messageText from $messageSender');
                    // ضيف العنصر بشكله النهائي ف القايمه
                    messageWidgets.add(messageWidget);
                  }
                }
                // دا العمود اللي هيتعرض للمستخدم بشكل بدائي
                return Column(
                    // بما انه بياخد ليسته هحط فيه ليسته الرسايل اللي انا لسا بانيها خالا
                    children : messageWidgets
                );
              },
            ),
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
