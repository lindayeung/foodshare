class User {
  final String firstName;
  final int age;
  final String bio;
  final String diet;
  final String gender;

  User(this.firstName, this.age, this.bio, this.diet, this.gender);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        bio = json['bio'],
        diet = json['diet'],
        gender = json['gender'],
        age = int.parse(json['age']);

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'age': age.toString(),
        'bio': bio,
        'diet': diet,
        'gender': gender
      };

  storeAsString() {
    this.toJson().toString();
  }
}
