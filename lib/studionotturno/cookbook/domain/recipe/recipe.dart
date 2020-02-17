
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';

import 'dart:html';

///una ricetta è formata sia da ingredienti semplici (sale,olio ecc...) ma anche
/// da ingredienti composti ( es: impasto per la pizza che contiene farina,acqua,sale ecc...).
///Dovendo utilizzare istanze di Ingredient è anche il Creator di Ingredient,
///userà un registro di Factory o un Factory per gli ingredienti.
/// Dovendo memorizzare gli ingredienti è anche Information expert (grasp) degli ingredient
class Recipe {

  String name;
  String description;
  int difficult;
  List<Ingredient> ingredients;
  ExecutionTime executionTime;

  IngredientRegister ingredientRegister;

  Recipe(this.name){
    this.ingredients=new List<Ingredient>();
    ingredientRegister=new IngredientRegister();
    //if(ingredientRegister.getIngredientFactories().length==0)ingredientRegister.loadFactories();
  }

  String getName(){
    return this.name;
  }
  String getDescription(){
    return this.description;
  }
  int getDifficult(){
    return this.difficult;
  }
  List<Ingredient> getIngredients(){
    return this.ingredients;
  }
  ExecutionTime getExecutionTime(){
    return this.executionTime;
  }
  void setName(String name){
    this.name=name;
  }
  void setDifficult(int difficult){
    this.difficult=difficult;
  }
  void setDescription(String description){
    this.description=description;
  }
  void setExecutionTime(ExecutionTime executionTime){
    this.executionTime=executionTime;
  }

  CompositeIngredient getIngredient(String name) {
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(!containsByName(name)) throw new Exception("Ingrediente non presente");
    return ingredients.firstWhere((el)=>el.getName()==name);
  }

  Recipe add(Ingredient ingredient){
    if(ingredient==null) throw new Exception("Ingrediente null");
    if(contains(ingredient)) throw new Exception("Ingrediente già presente");
    this.ingredients.add(ingredient);
    return this;
  }

  ///Aggiunta di un ingrediente semplice a questa ricetta
  /// Usando un meccanismo di delega viene creata l'istanza usando il register dei factory method per la creazione
  /// di una istanza Ingrediente e aggiunta alla ricetta
  Recipe addSimple(String name,double amount,String unit){
    this.ingredients.add(ingredientRegister.getFactory("simple").createIngredient(name, amount, unit));
    return this;
  }

  ///Aggiunta di un ingrediente composto a questa ricetta
  /// Usando un meccanismo di delega viene creata l'istanza usando il register dei factory method per la creazione
  /// di una istanza Ingrediente e aggiunta alla ricetta
  Recipe addComposite(String name,double amount,String unit){
    this.ingredients.add(ingredientRegister.getFactory("composite").createIngredient(name, amount, unit));
    return this;
  }

  /// Viene controllato se l'ingrediente è presente in questa ricetta
  /// Nel caso in cui l'ingrediente cercato sia un componente di un ingrediente composto
  /// non verrà trovato; verrà trovato se è effettivamente un ingrediente composto o un ingrediente semplice isolato
  /// Ritorna true se è stato trovato, false altrimenti
  bool contains(Ingredient ingredient) {
    if(ingredient==null) throw new Exception("Ingrediente null");
    bool trovato=false;
    for(Ingredient ingRecipe in this.ingredients){
      if(ingRecipe is SimpleIngredient && ingredient is SimpleIngredient){
        if(ingRecipe.getName()==ingredient.getName()) trovato=true;
      }
      else if(ingRecipe is CompositeIngredient && ingredient is SimpleIngredient){
        if((ingRecipe as CompositeIngredient).contains(ingredient.getName()))trovato=true;
        /*for(Ingredient comp in ingRecipe.getIngredients()) {
          if(comp.getName()==ingredient.getName())trovato=true;
        }*/
      }
      else if(ingRecipe is CompositeIngredient && ingredient is CompositeIngredient){
        if(ingRecipe.equals(ingredient))trovato=true;
      }
    }
    return trovato;
  }

  /// Viene controllato se l'ingrediente è presente in questa ricetta
  /// Nel caso in cui l'ingrediente cercato sia un componente di un ingrediente composto
  /// non verrà trovato; verrà trovato se è effettivamente un ingrediente composto o un ingrediente semplice isolato
  /// Ritorna true se è stato trovato, false altrimenti
  bool containsByName(String name) {
    if(name==null || name=="") throw new Exception("Ingrediente null");
    bool trovato=false;
    for (Ingredient el in this.ingredients) {
      if(el.getName()==name)trovato=true;
      /*if(el is SimpleIngredient){
        if ((el as SimpleIngredient).getName() == name) trovato= true;
      }
      if(el is CompositeIngredient){
        if ((el as CompositeIngredient).contains(name)) trovato = true;
      }*/
    }
    return trovato;
  }

  ///Viene cancellato un ingrediente dalla ricetta uando una istanza di Ingredient;
  ///Se l'ingrediente cercato è un componente di un ingrediente composto non verrà trovato
  ///Verrà cancellato se è effettivamente un ingrediente composto o un ingrediente semplice isolato
  void remove(Ingredient ingredient) {
    if(ingredient==null) throw new Exception("Ingrediente null");
    if(!contains(ingredient)) throw new Exception("Ingrediente non trovato");
      if(ingredient is SimpleIngredient){
        this.ingredients.removeWhere((el)=>ingredient.equals(el));
      }
      else if(ingredient is CompositeIngredient){
        this.ingredients.removeWhere((el)=>ingredient.equals(el));
      }
  }

  ///Viene cancellato un ingrediente dalla ricetta in base al suo nome;
  ///Se l'ingrediente cercato è un componente di un ingrediente composto non verrà trovato
  ///Verrà cancellato se è effettivamente un ingrediente composto o un ingrediente semplice isolato
  void removeByName(String name){
    if(name==null || name=="") throw new Exception("Ingrediente null");
    if(!containsByName(name)) throw new Exception("ingredient non trovato");
    this.ingredients.removeWhere((el)=>el.getName()==name);
  }

  ///Ritorna true se la ricetta non ha ingredienti,false altrimenti
  bool isEmpty(){
    return this.ingredients.isEmpty;
  }

  ///Cancellazione di tutti gli ingredienti di questa ricetta
  void clear(){
    this.ingredients.clear();
  }

  @override
  String toString() {
    return "'name':'$name','description':'$description','difficult:'$difficult','executionTime':'$executionTime','ingredients':$ingredients}";
  }

  Map<String,dynamic> toJson(){
    return {
      "name": this.name,
      "description": this.description,
      "difficult": this.difficult,
      "executionTime": this.executionTime,
      "ingredients":this.ingredients
    };
  }

  Recipe fromJson(Map<String, dynamic> json){
    name = json['name'];
    description = json['description'];
    difficult = json['difficult'];
    //String m=json['executionTime'].toString();
    //executionTime= new ExecutionTime(0,0).fromJson(m);
    //ingredients = json['ingredients'];
    return this;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recipe &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          difficult == other.difficult &&
          ingredients == other.ingredients &&
          executionTime == other.executionTime &&
          ingredientRegister == other.ingredientRegister;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      difficult.hashCode ^
      ingredients.hashCode ^
      executionTime.hashCode ^
      ingredientRegister.hashCode;


}