import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'package:foodshare/Screens/HomePage.dart';
import 'package:foodshare/Screens/LoginPage.dart';
import 'package:foodshare/Screens/ProfileSettingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@Protocol Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        ProfileSettingPage.id: (context) => ProfileSettingPage(),
      },
    );
  }
}
