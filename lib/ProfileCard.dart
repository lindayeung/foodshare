import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  String atSign;
  String firstName;
  String bio;
  String gender;
  String diet;
  int age;

  @override
  ProfileCard(String atSign, String firstName, String bio, String gender,
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
    return Center(
      child: Container(
        width: 300,
        height: 500,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/young-african-woman-eating-healthy-vegetable-salad-happy-african-american-woman-eating-healthy-vegetable-salad-young-woman-114152293.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                firstName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('$gender, $age'),
              SizedBox(height: 50),
              Text(
                'About Me',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(bio, textAlign: TextAlign.center),
              ),
              SizedBox(height: 30),
              Text(
                'My Diet',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 5),
              Text(diet),
            ],
          ),
        ),
      ),
    );
  }
}
