import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodshare/Recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  Recipe recipe;

  RecipeDetailPage({this.recipe});
/* Scaffold(
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
            ListView(children: [
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
          recipe.name,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 60),
        Text(
          'Ingredients',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Column(
          children: recipe.ingredients == null
              ? []
              : recipe.ingredients
                  .map<Widget>((ingredient) => Row(children: [
                        Text(
                          ingredient.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ]))
                  .toList(),
        ),
        SizedBox(height: 80),
        Text(
          'Steps',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Column(
          children: recipe.steps == null
              ? []
              : recipe.steps.asMap().entries.map((step) {
                  int i = step.key;

                  return Row(children: [
                    Text(
                      '${(i + 1).toString()}. ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                    ),
                    Text(
                      step.value,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ]);
                }).toList(),
        ),
      ])
          ),
          Center(
            child: ProfileCard(atSign, firstName, bio, gender, diet, age),
          )
        ],
      ),
    )*/
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
                    'https://images.unsplash.com/photo-1544021770-7fe1de901890?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fGZvb2R8ZW58MHwxfDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.srcOver),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                recipe.name,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(height: 60),
              Text(
                'Ingredients',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                children: recipe.ingredients == null
                    ? []
                    : recipe.ingredients
                        .map<Widget>((ingredient) => Row(children: [
                              Text(
                                ingredient.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ]))
                        .toList(),
              ),
              SizedBox(height: 80),
              Text(
                'Steps',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                children: recipe.steps == null
                    ? []
                    : recipe.steps.asMap().entries.map((step) {
                        int i = step.key;

                        return Row(children: [
                          Text(
                            '${(i + 1).toString()}. ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                                color: Colors.white),
                          ),
                          Text(
                            step.value,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ]);
                      }).toList(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
