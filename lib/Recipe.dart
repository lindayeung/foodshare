class Recipe {
  String name;
  List<Ingredient> ingredients;
  List<String> steps = [];

  Recipe({this.name, this.ingredients, this.steps});

  @override
  String toString() {
    // TODO: implement toString
    return name + '\n' + ingredients.toString() + '\n' + steps.toString();
  }

  Map toJson() {
    ingredients.map((e) => {e.toJson()});

    return {'name': name, 'ingredients': ingredients, 'steps': steps};
  }

  Recipe.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        steps = json['steps'],
        ingredients = json['ingredients'];

  static decodedRecipe(Map<String, dynamic> decoded) {
    List<Ingredient> ingredients;
    var ingredientsDecoded = decoded['ingredients'];

    ingredients = (ingredientsDecoded as List).map((i) {
      print(i);
      return Ingredient.fromJson(i);
    }).toList();

    return Recipe(
        name: decoded['name'],
        ingredients: ingredients,
        steps: new List<String>.from(decoded['steps']));
  }
}

class Ingredient {
  int quantity;
  String name;

  Ingredient({this.quantity, this.name});

  @override
  String toString() {
    // TODO: implement toString
    return quantity.toString() + ' x ' + name;
  }

  Map toJson() => {
        'quantity': quantity,
        'name': name,
      };

  Ingredient.fromJson(Map<String, dynamic> json)
      : quantity = json['quantity'],
        name = json['name'];

  static Ingredient decodedIngredient(Map<String, dynamic> decoded) {
    return Ingredient(quantity: decoded['quantity'], name: decoded['name']);
  }
}
