import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'LoginPage.dart';
import 'package:foodshare/ProfileCard.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ServerDemoService _atClientService = ServerDemoService.getInstance();
  String firstName;
  String bio;
  String gender;
  String diet;
  int age;

  /*
  Center(
      child: ProfileCard(atSign, firstName, bio, gender, diet, age),
    );
   */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1533777168198-c2a016551f63?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1234&q=80'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.srcOver),
              ),
            ),
          ),
          Center(
            child: ProfileCard(atSign, firstName, bio, gender, diet, age),
          )
        ],
      ),
    );
  }

  _fetchUserProfile() async {
    AtKey lookup = AtKey();
    String response;
    lookup.sharedWith = atSign;

    lookup.key = 'first_name';
    response = await _atClientService.get(lookup);
    if (response != null) {
      setState(() {
        firstName = response;
      });
    }

    lookup.key = 'age';
    response = await _atClientService.get(lookup);
    print(response);
    if (response != null) {
      int responseInt = int.tryParse(response);
      if (responseInt != null) {
        setState(() {
          age = responseInt;
        });
      }
    }

    lookup.key = 'bio';
    response = await _atClientService.get(lookup);
    if (response != null) {
      setState(() {
        bio = response;
      });
    }

    lookup.key = 'gender';
    response = await _atClientService.get(lookup);
    if (response != null) {
      setState(() {
        gender = response;
      });
    }

    lookup.key = 'diet';
    response = await _atClientService.get(lookup);
    if (response != null) {
      setState(() {
        diet = response;
      });
    }
  }
}
