
import 'dart:collection';

import 'package:ricettario/studionotturno/cookbook/domain/Iterator/concreteIteratorAscending.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/concreteIteratorByIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/concreteIteratorByName.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/concreteIteratorByTime.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/iterableCollection.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

import 'concreteIteratorByDifficult.dart';


///Un Singleton e unico accesso alla creazioni di ricette e ingredienti da inserire nelle ricette.
///L'utente accede al proprio ricettario per vedere e creare ricette.
///E' una ConcreteCollection del pattern Iterator.
class Cookbook extends IterableCollection{

  static final Cookbook _cookBook=Cookbook._internal();
  static HashSet<Recipe> recipes;

  Cookbook._internal();

  factory Cookbook(){
    if(recipes==null) {
      recipes = new HashSet<Recipe>();
    }
      return _cookBook;
  }

  Set<Recipe> getRecipes(){
    Set<Recipe> orderedRecipes=new Set<Recipe>();
    RecipesIterator it=createIteratorAscending(recipes);
        while(it.hasNext()) orderedRecipes.add(it.next());
    return orderedRecipes;

    /*recipes.toList().sort((a,b)=>a.getName().compareTo(b.getName()));
    return recipes.toSet();*/
  }

  ///consente ci avere l'istanza dela ricetta in base al nome; le ricette hanno un nome univo e non ripetibile
  Recipe getRecipe(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(!containsByName(name)) throw new Exception("ricetta non presete");
    return recipes.where((r)=>r.getName()==name).toList().elementAt(0);
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
    return recipes.contains(recipe);
  }

  /// Consente di sapere se una ricetta, in base al suo nome, è stata menorizzata nel ricettario
  /// Le ricette hanno un nome univoco nel ricettario
  bool containsByName(String name){
    if(name==null || name=="") throw new Exception("Nome non valido");
    return recipes.where((el)=>el.getName()==name).toList().length>0?true:false;
  }

  void clear() {
    if(recipes.isNotEmpty)recipes.clear();
  }

  bool remove(Recipe r) {
    if(r==null) throw new Exception("Ricetta nulla");
    if(!contains(r)) throw new Exception("Ricetta non presente");
    return recipes.remove(r);
  }

  @override
  RecipesIterator createIteratorByDifficult(Set<Recipe> set,int difficult) {
    return new ConcreteIteratorByDifficult(set,difficult);
  }

  @override
  RecipesIterator createIteratorByIngredient(Set<Recipe> set,String ingredientName) {
    return new ConcreteIteratorByIngredient(set,ingredientName);
  }

  @override
  RecipesIterator createIteratorByName(Set<Recipe> set,String name) {
    return new ConcreteIteratorByName(set, name);
  }

  @override
  RecipesIterator createIteratorByTime(Set<Recipe> set,int minutes) {
    return new ConcreteIteratorByTime(set, minutes);
  }

  @override
  RecipesIterator createIteratorAscending(Set<Recipe> set) {
    return new ConcreteIteratorAscending(set);
  }
  

}