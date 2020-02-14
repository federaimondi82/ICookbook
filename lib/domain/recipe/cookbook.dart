

import 'dart:collection';

import 'package:ricettario/domain/recipe/recipe.dart';

class CookBook{

  static final CookBook _cookBook=CookBook._internal();
  static List<Recipe> recipes;

  CookBook._internal();

  factory CookBook(){
    if(recipes==null) recipes=new List<Recipe>();
    return _cookBook;
  }

  List<Recipe> getRecipes(){
    return recipes;
  }

  Recipe getRecipe(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(!containsByName(name)) throw new Exception("ricetta non presete");
    return recipes.firstWhere((el)=>el.getName()==name);
  }

  void addRecipe(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(containsByName(name)) throw new Exception("ricetta esistente");
    recipes.add(new Recipe(name));
  }

  bool contains(Recipe recipe){
    if(recipe==null) throw new Exception("Ricetta nulla");
    bool trovato=false;
    for (Recipe el in recipes) {
      if (el==recipe) trovato = true;
    }
    return trovato;
  }

  bool containsByName(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    bool trovato=false;
    for (Recipe el in recipes) {
      if (el.getName() == name) trovato = true;
    }
    return trovato;
  }

  void clear() {
    recipes.clear();
  }

  void remove(Recipe r) {
    if(r==null) throw new Exception("Ricetta nulla");
    if(!this.contains(r)) throw new Exception("Ricetta non presente");
    recipes.remove(r);
  }

}