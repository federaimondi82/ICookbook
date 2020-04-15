

import 'dart:convert';

import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/recipeAdapter.dart';


///Rappresenta un mediatore di dati tra il FileManager del packege Level_1 (foundation) e
///lo starto superiore del package adapter.
///E' una Pure Fabrication, una classe che esiste solo concettualemente.
/// Serve per mediare i dati tra gli strati inferiori e quelli superiori.
class Mediator{

  FileManager fileManager;
  List<Recipe> recipes;
  Cookbook cookbook;
  Mediator(){
    this.fileManager=new FileManager();
    this.recipes=new List<Recipe>();
    this.cookbook=new Cookbook();
  }

  ///Carica le ricette dal file in una struttura dati ( recipes )
  void loadDataFromFile() async {
    await this.fileManager.readDataIntoFile().then((ele)=>ele.forEach((ele){
      this.recipes.add(RecipeAdapter().toObject(ele));
    }));
    this.recipes.toSet().forEach((recipe)=>cookbook.addRecipeObject(recipe));
  }

  ///salvataggio di una singola ricetta nel file; usa FileManager
  void uploadRecipeIntoFile(Recipe r) async{

    Map<String,dynamic> s1=RecipeAdapter().setRecipe(r).toJson();
    String s2=JsonEncoder().convert(s1);

    this.fileManager.saveRecipe(s2);

  }

  ///Consente di memorizzare tutte le ricette in locale
  void uploadAllRecipes() {
    List<String> recipes=new List<String>();
    this.cookbook.getRecipes().forEach((recipe){
      Map<String,dynamic> s1=RecipeAdapter().setRecipe(recipe).toJson();
        recipes.add(JsonEncoder().convert(s1));
    });
    this.fileManager.saveAllRecipes(recipes);
  }


}