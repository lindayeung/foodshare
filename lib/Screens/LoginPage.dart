import 'package:at_server_status/at_server_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Screens/HomePage.dart';
import 'package:foodshare/Screens/ProfileSettingPage.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;

String atSign;

class LoginPage extends StatefulWidget {
  static final String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: AssetImage('images/landing-page.jpeg'),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.srcOver))),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'FoodShare',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset('images/atsign.png',
                            width: 50, height: 50),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Enter your at-sign'),
                          onChanged: (value) {
                            atSign = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  TextButton(
                    onPressed: _login,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrangeAccent),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text('Login'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _login() async {
    print('logging in...');
    if (atSign.characters.first != '@') {
      atSign = "@" + atSign;
    }

    print(atSign);

    String jsonData = _serverDemoService.encryptKeyPairs(atSign);

    if (atSign != null) {
      _serverDemoService.onboard(atsign: atSign).then((value) async {
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //   return HomePage(
        //     firstTimeUser: false,
        //   );
        // }));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ProfileSettingPage();
        }));
      }).catchError((error) async {
        print('error..');

        await _serverDemoService.authenticate(atSign,
            jsonData: jsonData, decryptKey: at_demo_data.aesKeyMap[atSign]);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ProfileSettingPage();
        }));
      });
    }
  }
}
