
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipeIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';



///Responsabilità di effettuare ricerche di ingedienti e ricette nel ricettario
///E' possibile effettuare ricerche multiple
class ConcreteIteratorLocal implements RecipeIterator{

  static Cookbook cookBook;
  static Set<Recipe> list;


  ConcreteIteratorLocal(){
    if(cookBook==null) cookBook=new Cookbook();
    if(list==null) list=new Set<Recipe>();
  }

  RecipeIterator searchByRecipeName(String name){
    if(name=="" || name==null) throw new Exception("nome non valido");
    cookBook.getRecipes().forEach((el){
      if(el.getName().toString().contains(name)) list.add(el);
    });
    return this;
  }

  RecipeIterator searchByIngredient(Ingredient ingredient){
    if(ingredient==null) throw new Exception("ingrediente nullo");
    list.addAll(cookBook.getRecipes().where((el)=>el.contains(ingredient)));
    return this;
  }

  RecipeIterator searchByIngredients(List<Ingredient> ingredients){
    if(ingredients==null) throw new Exception("ingredienti non validi");
    for(Ingredient ing in ingredients){
      list.addAll(cookBook.getRecipes().where((el)=>el.contains(ing)));
    }
    return this;
  }

  RecipeIterator searchByIngredientName(String name){
    if(name==null || name=="") throw new Exception("nome non valido");
    for(Recipe recipe in cookBook.getRecipes()){//per ogni ricetta
      for(Ingredient ing in recipe.getIngredients()){//per ogni ingrediente
        if(ing is SimpleIngredient){
          if(ing.getName()==name) list.add(recipe);
        }
        if(ing is CompositeIngredient){
          if(ing.getName()==name) list.add(recipe);
          for(Ingredient simple in ing.getIngredients()){
            if(simple.getName()==name) list.add(recipe);
          }
        }
      }
    }
    return this;
  }

  RecipeIterator searchByDifficult(int difficult){
    if(difficult==null || difficult<0) throw new Exception("Difficoltà non valida");
    list.addAll(cookBook.getRecipes().where((el)=>el.getDifficult()==difficult));
    return this;
  }

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  RecipeIterator clear() {
    list.clear();
    return this;
  }

  Set<Recipe> getRecipes(){
    return list;
  }

  RecipeIterator searchByExecutionTime(int minutes) {
    if(minutes==null || minutes<0) throw new Exception(" tempo non valido");
    print("2.1");
    list.addAll(cookBook.getRecipes().where((el)=>
        el.getExecutionTime().toMinutes()<=minutes)
    );
    print("2.2");
    return this;
  }

  @override
  RecipeIterator thenByRecipeName(String name) {
    if(name=="" || name==null) throw new Exception("nome non valido");
    Set<Recipe> toRemove=new Set<Recipe>();
    list.forEach((el){
      if(!el.getName().contains(name)) toRemove.add(el);
    });
    list.removeAll(toRemove);
    return this;
  }

  RecipeIterator thenByIngredient(Ingredient ingredient){
    if(ingredient==null) throw new Exception("ingrediente nullo");
    Set<Recipe> toRemove=list.where((el)=>!el.contains(ingredient)).toSet();
    list.removeAll(toRemove);
    return this;
  }

  RecipeIterator thenByIngredients(List<Ingredient> ingredients){
    if(ingredients==null) throw new Exception("ingredienti non validi");
    Set<Recipe> toRemove=new Set<Recipe>();
    for(Ingredient ing in ingredients){
      toRemove=list.where((el)=>!el.contains(ing)).toSet();
    }
    list.removeAll(toRemove);
    return this;
  }

  RecipeIterator thenByIngrendientName(String name){
    if(name==null || name=="") throw new Exception("nome non valido");
    Set<Recipe> lascia=new Set<Recipe>();
    for(Recipe recipe in list){//per ogni ricetta
      for(Ingredient ing in recipe.getIngredients()){//per ogni ingrediente
        if(ing is SimpleIngredient){
          if((ing as SimpleIngredient).getName()==name) lascia.add(recipe);
        }
        if(ing is CompositeIngredient){
          if(ing.getName()==name) lascia.add(recipe);
          for(Ingredient simple in ing.getIngredients()){
            if(simple.getName()==name) lascia.add(recipe);
          }
        }
      }
    }
    list.clear();
    list.addAll(lascia);
    return this;

  }

  RecipeIterator thenByDifficult(int difficult) {
    if(difficult==null || difficult<0) throw new Exception("Difficoltà non valida");
    Set<Recipe> lascia=list.where((el)=>el.getDifficult()==difficult).toSet();
    list.clear();
    list.addAll(lascia);
    return this;
  }

  RecipeIterator thenByExecutionTime(int minutes){
    if(minutes==null || minutes<0) throw new Exception(" tempo non valido");

    Set<Recipe> lascia=list.where((el)=>
      el.getExecutionTime().toMinutes()<=minutes
    ).toSet();
    list.clear();
    list.addAll(lascia);
    return this;
  }

  @override
  RecipeIterator addDeletedIngredientName(String name) {
    // TODO: implement addDeletedIngredientName
    return null;
  }

  @override
  RecipeIterator addDeletedRecipeName(String name) {
    // TODO: implement addDeletedRecipeName
    return null;
  }



}