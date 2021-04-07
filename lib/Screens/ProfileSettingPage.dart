import 'dart:io';

import 'package:at_server_status/at_server_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Screens/HomePage.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'package:foodshare/Screens/LoginPage.dart';
import 'package:foodshare/User.dart';

class ProfileSettingPage extends StatefulWidget {
  static final String id = 'profileSetting';

  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 40.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to FoodShare!',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Fill out a few information about yourself so we can find your culinary community!',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '(Don\'t worry, your information is kept safe through the @ protocol)',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ProfileSettingForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSettingForm extends StatefulWidget {
  @override
  _ProfileSettingFormState createState() => _ProfileSettingFormState();
}

class _ProfileSettingFormState extends State<ProfileSettingForm> {
  String _name;
  DateTime _birthday;
  String _bio;
  String _diet;
  String _gender;
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool isSwitched5 = false;

  ServerDemoService _atClientService = ServerDemoService.getInstance();

  @override
  Widget build(BuildContext context) {
    var diets = <String>['Keto', 'Vegan', 'Paleo', 'None'];
    var genders = <String>['Male', 'Female', 'Non-binary'];

    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Stack(children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'What do people call you?',
                labelText: 'Name',
              ),
              validator: (String value) {
                return (value != null) ? 'Please enter a name' : null;
              },
              onChanged: (value) {
                _name = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 260, top: 10),
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.orangeAccent,
                activeColor: Colors.deepOrangeAccent,
              ),
            ),
          ]),
          SizedBox(height: 40),
          Stack(children: [
            InputDatePickerFormField(
              firstDate: DateTime(1970),
              lastDate: DateTime.now(),
              fieldLabelText: 'Birthday',
              onDateSubmitted: (value) {
                _birthday = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 260, top: 10),
              child: Switch(
                value: isSwitched2,
                onChanged: (value) {
                  setState(() {
                    isSwitched2 = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.orangeAccent,
                activeColor: Colors.deepOrangeAccent,
              ),
            ),
          ]),
          SizedBox(height: 40),
          Stack(
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Tell the world a bit about yourself!',
                  labelText: 'Short Bio',
                ),
                onChanged: (value) {
                  _bio = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260, top: 10),
                child: Switch(
                  value: isSwitched3,
                  onChanged: (value) {
                    setState(() {
                      isSwitched3 = value;
                      print(isSwitched3);
                    });
                  },
                  activeTrackColor: Colors.orangeAccent,
                  activeColor: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Stack(
            children: [
              DropdownButton<String>(
                hint: Text('Gender'),
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                value: _gender,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260, top: 10),
                child: Switch(
                  value: isSwitched4,
                  onChanged: (value) {
                    setState(() {
                      isSwitched4 = value;
                      print(isSwitched4);
                    });
                  },
                  activeTrackColor: Colors.orangeAccent,
                  activeColor: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Stack(
            children: [
              DropdownButton<String>(
                hint: Text('Are you on a special diet?'),
                items: diets.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _diet = value;
                  });
                },
                value: _diet,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260, top: 10),
                child: Switch(
                  value: isSwitched5,
                  onChanged: (value) {
                    setState(() {
                      isSwitched5 = value;
                      print(isSwitched5);
                    });
                  },
                  activeTrackColor: Colors.orangeAccent,
                  activeColor: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Center(
            child: TextButton(
              onPressed: _updateProfile,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('I\'m ready!'),
            ),
          )
        ],
      ),
    );
  }

  _updateProfile() async {
    DateTime currentDate = DateTime.now();
    Duration ageDuration = currentDate.difference(_birthday);
    int age = (ageDuration.inDays / 365).floor();

    User user = User(_name, age, _bio, _diet, _gender);

    AtKey atKey = AtKey();
    atKey.sharedWith = atSign;
    atKey.sharedBy = atSign;

    atKey.namespace = 'user.foodshare';

    atKey.key = 'first_name';
    await _atClientService.put(atKey, user.firstName);

    atKey.key = 'birthday';
    await _atClientService.put(atKey, _birthday.toString());

    atKey.key = 'age';

    await _atClientService.put(atKey, user.age.toString());

    atKey.key = 'bio';
    await _atClientService.put(atKey, user.bio);

    atKey.key = 'gender';
    await _atClientService.put(atKey, user.gender);

    atKey.key = 'diet';
    await _atClientService.put(atKey, user.diet);

    // var metadata = Metadata()..isPublic = true;
    // atKey.key = 'onboarded';
    // atKey.sharedBy = atSign;
    // atKey.metadata = metadata;
    // await _atClientService.put(atKey, 'true');

    List<String> otherAtSigns = at_demo_data.allAtsigns;
    otherAtSigns.remove(atSign);

    for (String otherAtSign in otherAtSigns) {
      AtKey onboardKey = AtKey();
      onboardKey.namespace = 'onboardeded.foodshare';
      onboardKey.metadata = Metadata()..isPublic = true;

      onboardKey.key = atSign.substring(1) +
          '-' +
          otherAtSign.substring(1) +
          '-onboardedBob';

      onboardKey.sharedWith = otherAtSign;
      onboardKey.sharedBy = atSign;

      print(onboardKey);

      try {
        var operation = OperationEnum.update;
        await _atClientService.notify(atKey, 'true', operation);
        print('Sending onboarded key to $otherAtSign successful.\n\n');
      } catch (e) {
        print('Sending onboarded key to $otherAtSign failed.\n\n');
        continue;
      }
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomePage(
        firstTimeUser: false,
      );
    }));
  }
}
