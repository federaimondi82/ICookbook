

import 'package:ricettario/studionotturno/cookbook/Level_1/imageManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'executionTimeAdapter.dart';
import 'ingredientAdapter.dart';
import 'target.dart';
import 'recipeAdapter.dart';

class DocumentAdapter extends Target{

  Recipe recipe;
  User user;
  ImageManager imageManager;

  DocumentAdapter(){
    this.imageManager=new ImageManager();
  }

  DocumentAdapter setRecipe(Recipe recipe){
    this.recipe=recipe;
    this.imageManager.setRecipeName(this.recipe.getName());
    return this;
  }

  DocumentAdapter setUserName(){
    this.user=new User();
    return this;
  }


  @override
  Map<String,dynamic > toJson() {
    return{
      "userName": user.getEmail(),
      "recipeName":this.recipe.getName(),
      "descrition":this.recipe.getDescription(),
      "difficult":this.recipe.getDifficult(),
      "executionTime":this.recipe.getExecutionTime().toMinutes(),
      "ingredients":this.recipe.ingredients.map((model)=>IngredientAdapter().setIngredient(model).toJson()).toList(),
      "photos":[]
    };
  }

  @override
  Recipe toObject(Map<dynamic,dynamic> data) {
    this.recipe=new Recipe("");
    this.recipe.name = data['recipeName'];
    this.recipe.description = data['description'];
    this.recipe.difficult = data['difficult'];
    this.recipe.executionTime=ExecutionTimeAdapter().toObject(data['executionTime']);
    Iterable l= data['ingredients'];
    this.recipe.ingredients = l.map((model)=>IngredientAdapter().toObject(model)).toList();
    return this.recipe;
  }

}