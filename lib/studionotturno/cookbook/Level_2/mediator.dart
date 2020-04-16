

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
  Future<bool> loadDataFromFile() async {
    await this.fileManager.readDataIntoFile().then((ele)=>ele.forEach((ele){
      this.recipes.add(RecipeAdapter().toObject(ele));
    })).then((value1){
      this.recipes.toSet().forEach((recipe)=>cookbook.addRecipeObject(recipe));
    });
    print("1");
    return await Future.value(true);

  }

  ///salvataggio di una singola ricetta nel file; usa FileManager
  void uploadRecipeIntoFile(Recipe r) async{

    Map<String,dynamic> s1=RecipeAdapter().setRecipe(r).toJson();
    String s2=JsonEncoder().convert(s1);

    this.fileManager.saveRecipe(s2);

  }

  ///Consente di memorizzare tutte le ricette in locale
  ///Le ricette a runtime vengono salvate su un file
  Future<bool> saveAllRecipes() async{
    List<String> recipes=new List<String>();
    this.cookbook.getRecipes().forEach((recipe){
      Map<String,dynamic> s1=RecipeAdapter().setRecipe(recipe).toJson();
        recipes.add(JsonEncoder().convert(s1));
    });
    await this.fileManager.saveAllRecipes(recipes);
    return Future.value(true);
  }


}