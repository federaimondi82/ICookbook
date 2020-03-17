

import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/executionTimeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/simpleIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/target.dart';

import 'compositeIngredientAdapter.dart';
import 'ingredientAdapter.dart';

///Implementa Target e è quindi la classe Adattatore di una Ricetta.
///Adatta i dati tra client e server, cioè tra i dati in locale e quilli in cloud.
///E' una classe del desing pattern Adapter
class RecipeAdapter extends Target{

  Recipe recipe;

  RecipeAdapter(){
    this.recipe=new Recipe("name");
  }

  RecipeAdapter setRecipe(Recipe recipe){
    this.recipe=recipe;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": this.recipe.name,
      "description": this.recipe.description,
      "difficult": this.recipe.difficult,
      "executionTime": ExecutionTimeAdapter().setTime(this.recipe.executionTime).toJson(),
      "ingredients":this.recipe.ingredients.map((model)=>IngredientAdapter().setIngredient(model).toJson()).toList()
    };
  }

  @override
  Recipe toObject(Map<String,dynamic> data) {
    this.recipe.name = data['name'];
    this.recipe.description = data['description'];
    this.recipe.difficult = data['difficult'];
    this.recipe.executionTime=ExecutionTimeAdapter().toObject(data['executionTime']);
    Iterable l= data['ingredients'];
    this.recipe.ingredients = l.map((model)=>IngredientAdapter().toObject(model)).toList();
    return this.recipe;
  }

}