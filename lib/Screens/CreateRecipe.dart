import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Screens/ProfileSettingPage.dart';
import 'package:foodshare/services/server_demo_service.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'LoginPage.dart';
import 'dart:convert';
import 'package:foodshare/Recipe.dart';

class CreateRecipe extends StatefulWidget {
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  String recipeName;
  List<Ingredient> ingredients = [];
  List<String> steps = [];
  ServerDemoService clientSdkService = ServerDemoService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, right: 25, left: 25, bottom: 55),
        child: ListView(children: [
          Row(
            children: [
              IconButton(
                  padding: EdgeInsets.only(bottom: 40),
                  iconSize: 40,
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
          Text(
            'Create Recipe',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: '(i.e. Buffalo cauliflower wings...)',
              labelText: 'Recipe Name',
            ),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            onChanged: (value) {
              recipeName = value;
            },
          ),
          SizedBox(height: 40),
          Text(
            'Ingredients',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          Column(
            children: ingredients.asMap().entries.map((ingredient) {
              int i = ingredient.key;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 20,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '1',
                          labelText: '',
                        ),
                        onChanged: (value) {
                          ingredients[i].quantity = int.parse(value);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Icon(Icons.clear),
                  ),
                  Container(
                    width: 280,
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: '(i.e. garlic cloves...)',
                          labelText: 'Ingredient Name',
                        ),
                        onChanged: (value) {
                          ingredients[i].name = value;
                        }),
                  )
                ],
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  padding: EdgeInsets.only(top: 40),
                  icon: Icon(Icons.add_circle_outline_outlined),
                  iconSize: 30,
                  onPressed: () {
                    setState(() {
                      ingredients.add(Ingredient());
                    });
                  }),
              Text(
                'Add Ingredient',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            'Steps',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          Column(
            children: steps.asMap().entries.map((step) {
              int i = step.key;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 375,
                    child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '(i.e. Add a dash of awesome... )',
                          labelText: '${i + 1}. ',
                        ),
                        onChanged: (value) {
                          steps[i] = value;
                        }),
                  )
                ],
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  padding: EdgeInsets.only(top: 40),
                  icon: Icon(Icons.add_circle_outline_outlined),
                  iconSize: 30,
                  onPressed: () {
                    setState(() {
                      steps.add('');
                    });
                  }),
              Text(
                'Add Step',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(height: 60),
          Text(
            'Share',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: '(i.e. @bob🛠)',
              labelText: 'Share to...',
            ),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            onChanged: (value) {},
          ),
          SizedBox(height: 80),
          Container(
            width: 400,
            alignment: Alignment.center,
            child: TextButton(
              onPressed: shareRecipe,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10.0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Ready to Serve!'),
            ),
          ),
        ]),
      ),
    );
  }

  shareRecipe() async {
    AtKey shareKey = AtKey();
    shareKey.sharedWith = atSign;
    shareKey.sharedBy = atSign;

    ingredients.removeWhere(
        (ingredient) => ingredient.quantity == null || ingredient.name == null);
    steps.removeWhere((element) => element.isEmpty);
    Recipe recipe =
        Recipe(name: recipeName, ingredients: ingredients, steps: steps);

    shareKey.key = 'recipe-' + atSign.substring(1) + '-' + recipeName;
    shareKey.namespace = 'recipes.foodshare';
    print(shareKey);
    await clientSdkService.put(shareKey, jsonEncode(recipe));

    Navigator.pop(context);
  }
}

class IngredientRow extends StatelessWidget {
  int quantity = 1;
  String name;

  @override
  IngredientRow({this.quantity, this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 20,
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '1',
                labelText: '',
              ),
              onChanged: (value) {
                quantity = int.parse(value);
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Icon(Icons.clear),
        ),
        Container(
          width: 280,
          child: TextField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: '(i.e. garlic cloves...)',
                labelText: 'Ingredient name',
              ),
              onChanged: (value) {
                name = value;
              }),
        )
      ],
    );
  }
}
