

import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/domain/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/recipeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/target.dart';

class DocumentAdapter extends Target{

  Recipe recipe;
  User user;

  DocumentAdapter(this.recipe){
    user=new User();
  }

  @override
  Map<String,dynamic > toJson() {
    // TODO: implement toJson
    return{
      "userName": user.getEmail(),
      "recipeName":this.recipe.getName(),
      "recipe":RecipeAdapter().setRecipe(this.recipe).toJson()
    };
  }

  @override
  Recipe toObject(Map<dynamic,dynamic> data) {
    this.recipe=RecipeAdapter().toObject(data['recipe']);
    return this.recipe;
  }

}