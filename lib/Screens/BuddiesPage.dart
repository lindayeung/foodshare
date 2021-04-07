import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Screens/ChatPage.dart';
import 'package:foodshare/Screens/FindPage.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'LoginPage.dart';
import '../utils/constants.dart';
import '../ProfileCard.dart';
import 'ChatPage.dart';

class BuddiesPage extends StatefulWidget {
  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  List<String> buddies;
  ServerDemoService clientSdkService = ServerDemoService.getInstance();

  @override
  void initState() {
    super.initState();

    List<String> allAtSigns = at_demo_data.allAtsigns;
    allAtSigns.remove(atSign);
    allAtSigns.removeAt(0);

    //TODO: set this to be only atSigns with open chats
    setState(() {
      buddies = allAtSigns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: buddies == null
            ? []
            : <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text(
                      "Food Buddies",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: goToFindPage,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 10.0)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrangeAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Text('Find New Food Buddy'),
                    ),
                  ),
                  SizedBox(height: 20)
                ] +
                buddies.map<Widget>((String otherAtSign) {
                  return Column(
                    children: [
                      MaterialButton(
                          onPressed: () {
                            openChat(otherAtSign);
                          },
                          child: BuddyChatCard(
                              otherAtSign,
                              otherAtSign.substring(1),
                              'bio',
                              'gender',
                              'diet',
                              22)),
                    ],
                  );
                }).toList(),
      ),
    );
  }

  void goToFindPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindPage()));
  }

  void openChat(String otherAtSign) {
    setChatWithAtSign(otherAtSign);
    initializeChatService(
        clientSdkService.atClientServiceInstance.atClient, atSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatPage()));
  }
}

class BuddyChatCard extends StatelessWidget {
  String atSign;
  String firstName;
  String bio;
  String gender;
  String diet;
  int age;

  @override
  BuddyChatCard(String atSign, String firstName, String bio, String gender,
      String diet, int age) {
    this.atSign = atSign;
    this.firstName = firstName;
    this.bio = bio;
    this.gender = gender;
    this.diet = diet;
    this.age = age;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Row(
          children: [
            SizedBox(width: 20),
            CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJV8n5usg2KF3449h2t6qyQXk6pn_54oDxjA&usqp=CAU')),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstName,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  atSign,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
