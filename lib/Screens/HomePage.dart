import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Screens/ProfileSettingPage.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'ProfilePage.dart';
import 'ChatPage.dart';
import 'FindPage.dart';
import 'BuddiesPage.dart';
import 'FoodFeedPage.dart';

class HomePage extends StatefulWidget {
  HomePage({this.firstTimeUser});

  static final String id = 'homepage';
  final firstTimeUser;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ProfilePage(),
    BuddiesPage(),
    FoodFeedPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepOrangeAccent,
          onTap: onTabTapped,
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              label: 'Buddies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Food Feed',
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
