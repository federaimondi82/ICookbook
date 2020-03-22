
import 'dart:collection';

import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';


class Cookbook{

  static final Cookbook _cookBook=Cookbook._internal();
  static HashSet<Recipe> recipes;

  Cookbook._internal();

  factory Cookbook(){
    if(recipes==null) {
      recipes = new HashSet<Recipe>();
    }
      return _cookBook;
  }

  /*HashSet<Recipe> getRecipes(){
    return recipes;
  }*/

  List<Recipe> getRecipes(){
    recipes.toList().sort((a,b)=>a.getName().compareTo(b.getName()));
    return recipes.toList();
  }

  ///consente ci avere l'istanza dela ricetta in base al nome; le ricette hanno un nome univo e non ripetibile
  Recipe getRecipe(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(!containsByName(name)) throw new Exception("ricetta non presete");
    Recipe r=null;
    for(Recipe el in recipes){
      if(el.getName()==name) r=el;
    }
    return r;
  }

  ///aggiunge na ricetta al ricettario
  void addRecipe(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(containsByName(name)) throw new Exception("ricetta esistente");
    recipes.add(new Recipe(name));
  }

  ///aggiunge na ricetta al ricettario
  void addRecipeObject(Recipe r){
    if(containsByName(r.getName())) throw new Exception("ricetta esistente");
    recipes.add(r);
  }

  /// Consente di sapere se una ricetta è stata menorizzata nel ricettario
  /// Le ricette hanno un nome univoco nel ricettario
  bool contains(Recipe recipe){
    if(recipe==null) throw new Exception("Ricetta nulla");
    bool trovato=false;
    for (Recipe el in recipes) {
      if (el==recipe) trovato = true;
    }
    return trovato;
  }

  /// Consente di sapere se una ricetta, in base al suo nome, è stata menorizzata nel ricettario
  /// Le ricette hanno un nome univoco nel ricettario
  bool containsByName(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    bool trovato=false;
    for (Recipe el in recipes) {
      if (el.getName() == name) trovato = true;
    }
    return trovato;
  }

  void clear() {
    if(recipes.isNotEmpty)recipes.clear();
  }

  bool remove(Recipe r) {
    if(r==null) throw new Exception("Ricetta nulla");
    if(!recipes.contains(r)) throw new Exception("Ricetta non presente");
    return recipes.remove(r);
  }

}