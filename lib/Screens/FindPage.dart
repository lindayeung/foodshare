import 'dart:io';

import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'LoginPage.dart';
import '../utils/constants.dart';
import '../ProfileCard.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  List<String> atSigns;
  ServerDemoService clientSdkService = ServerDemoService.getInstance();
  String chatWithAtSign;
  String activeAtSign;
  List<String> allAtSigns;

  @override
  void initState() {
    // TODO: Call function to initialize chat service.
    getAtSigns();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Find Food Buddies'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage('images/landing-page.jpeg'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.srcOver))),
          ),
          ListView(
            scrollDirection: Axis.horizontal,
            children: atSigns == null
                ? []
                : <Widget>[SizedBox(width: 20)] +
                    atSigns.map<Widget>((String otherAtSign) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  chatWithAtSign = otherAtSign;
                                  setAtsignToChatWith();
                                },
                                child: ProfileCard(
                                    otherAtSign,
                                    otherAtSign.substring(1),
                                    'Hi i love to eat!!',
                                    'Female',
                                    'Vegan',
                                    22)),
                          ],
                        ),
                      );
                    }).toList(),
          ),
        ],
      ),
    );
  }

  getAtSigns() async {
    setState(() {
      atSigns = at_demo_data.allAtsigns;
    });

    // String regex = '.*foodshare';
    //
    // List<AtKey> sharedKeysList = await clientSdkService.getAtKeys(regex: regex);
    //
    // var atKey = AtKey();
    // await sharedKeysList.forEach((element) async {
    //   atKey
    //     ..key = element.key
    //     ..sharedWith = element.sharedWith
    //     ..sharedBy = element.sharedBy;
    //
    //   print('$element\n\n');
    //
    //   if (atKey.sharedWith != null &&
    //       atKey.sharedBy != atSign.substring(1) &&
    //       atKey.sharedBy != null) {
    //     try {
    //       var response = await clientSdkService.get(atKey);
    //       print(atKey.key + ' ' + response);
    //     } catch (e) {
    //       print('$atKey.key failed.');
    //       return;
    //     }
    //   }
    // });
  }
  // setState(() {
  //   atSigns = allAtSigns;
  // });

  // Future<String> _lookup(AtKey atKey) async {
  //   if (atKey != null) {
  //     return await clientSdkService.get(atKey);
  //   }
  //   return '';
  // }

  // _scan() async {
  //   List<AtKey> response;
  //   String regex = '^(?!cached).*cookbook.*';
  //   response = await _serverDemoService.getAtKeys(regex: regex);
  //   List<String> responseList = [];
  //   for (AtKey atKey in response) {
  //     String value = await _lookup(atKey);
  //     value = atKey.key + constant.splitter + value;
  //     responseList.add(value);
  //   }
  //   return responseList;
  // }

  setAtsignToChatWith() {
    //Navigator.pop(context);
    //setChatWithAtSign(chatWithAtSign);
    //
    // initializeChatService(
    //     clientSdkService.atClientServiceInstance.atClient, activeAtSign,
    //     rootDomain: MixedConstants.ROOT_DOMAIN);
  }
}
