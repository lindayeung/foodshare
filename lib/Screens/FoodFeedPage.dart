import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Screens/ProfileSettingPage.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'LoginPage.dart';
import 'CreateRecipe.dart';
import 'package:foodshare/Recipe.dart';
import 'RecipeDetailPage.dart';

class FoodFeedPage extends StatefulWidget {
  @override
  _FoodFeedPageState createState() => _FoodFeedPageState();
}

class _FoodFeedPageState extends State<FoodFeedPage> {
  ServerDemoService clientSdkService = ServerDemoService.getInstance();
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    getCurrentAtSignRecipes();
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 25),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.add_box_outlined),
                            iconSize: 30,
                            color: Colors.deepOrangeAccent,
                            onPressed: () async {
                              final _ = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateRecipe()));
                              getCurrentAtSignRecipes();
                            }),
                        Text(
                          'New Post',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(25.0, 50, 25.0, 20),
                  children: <Widget>[
                        TextPostView(atSign, 'Good morning!'),
                        TextPostView(atSign, 'Any good vegan scampi recipe?!'),
                      ] +
                      recipes
                          .map<Widget>((recipe) => MaterialButton(
                                padding: EdgeInsets.only(top: 40),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetailPage(
                                                  recipe: recipe)));
                                },
                                child: RecipePostView(recipe: recipe),
                              ))
                          .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* body: Padding(
        padding: const EdgeInsets.only(top: 70, right: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.add_box_outlined),
                        iconSize: 30,
                        onPressed: () async {
                          final _ = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateRecipe()));
                          getCurrentAtSignRecipes();
                        }),
                    Text(
                      'New Post',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(25.0, 50, 25.0, 20),
                children: <Widget>[
                      TextPostView(atSign, 'Hi this is my first post!'),
                      TextPostView(atSign, 'Hi this is my first post!'),
                    ] +
                    recipes
                        .map<Widget>((recipe) => MaterialButton(
                              padding: EdgeInsets.only(top: 40),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecipeDetailPage(recipe: recipe)));
                              },
                              child: RecipePostView(recipe: recipe),
                            ))
                        .toList(),
              ),
            ),
          ],
        ),
      )*/

  getCurrentAtSignRecipes() async {
    List<AtKey> sharedKeysList =
        await clientSdkService.getAtKeys(regex: '.*foodshare');
    var recipesMap = {};
    var atKey = AtKey();
    var metadata = Metadata()..isCached = true;
    await sharedKeysList.forEach((element) async {
      atKey
        ..key = element.key
        ..sharedWith = element.sharedWith
        ..sharedBy = element.sharedBy;

      //print(atKey);

      if (atKey.key.contains('recipe')) {
        String response = await clientSdkService.get(atKey);
        print(response);
        if (response != null) {
          setState(() {
            recipes.add(Recipe.decodedRecipe(jsonDecode(response)));
            print(recipes);
          });
        }
      }
      //recipesMap.putIfAbsent('${element.key}', () => response);
    });
    return;
  }
}

class RecipePostView extends StatelessWidget {
  Recipe recipe;

  RecipePostView({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
              'https://thumbs.dreamstime.com/b/young-african-woman-eating-healthy-vegetable-salad-happy-african-american-woman-eating-healthy-vegetable-salad-young-woman-114152293.jpg'),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              atSign,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            Stack(
              children: [
                Image.network(
                    'https://assets.stickpng.com/thumbs/580b57fcd9996e24bc43c562.png',
                    width: 250,
                    height: 250),
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 5),
                  child: Container(
                    width: 250,
                    height: 250,
                    child: Text(
                      recipe.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TextPostView extends StatelessWidget {
  String atSign;
  String postText;

  TextPostView(String atSign, String postText) {
    this.atSign = atSign;
    this.postText = postText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                'https://thumbs.dreamstime.com/b/young-african-woman-eating-healthy-vegetable-salad-happy-african-american-woman-eating-healthy-vegetable-salad-young-woman-114152293.jpg'),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                atSign,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(postText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
