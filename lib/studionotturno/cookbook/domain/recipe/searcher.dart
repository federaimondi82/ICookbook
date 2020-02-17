
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';

///Responsabilità di effettuare ricerche di ingedienti e ricette nel ricettario
///E' possibile effettuare ricerche multiple
class Searcher{

  static final Searcher _searcher=Searcher._internal();
  static Cookbook cookBook;
  static Set<Recipe> list;

  Searcher._internal();

  factory Searcher(){
    if(cookBook==null) cookBook=new Cookbook();
    if(list==null) list=new Set<Recipe>();
    return _searcher;
  }
  
  Searcher searchByRecipeName(String name){
    if(name=="" || name==null) throw new Exception("nome non valido");
    list.add(cookBook.getRecipe(name));
    return this;
  }

  ///ricerca tutte quelle ricette che hanno un determinato ingrediente usando una istanza
  ///di tipo Ingredient.
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  Searcher searchByIngredient(Ingredient ingredient){
    if(ingredient==null) throw new Exception("ingrediente nullo");
    list.addAll(cookBook.getRecipes().where((el)=>el.contains(ingredient)));
    return this;
  }

  ///ricerca tutte quelle ricette che hanno un lista di ingredienti semplici
  ///al loro interno,vengono cercati gli ingredienti semplici anche in quelli composti
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  Searcher searchByIngredients(List<Ingredient> ingredients){
    if(ingredients==null) throw new Exception("ingredienti non validi");
    for(Ingredient ing in ingredients){
      list.addAll(cookBook.getRecipes().where((el)=>el.contains(ing)));
    }
    return this;
  }

  ///ricerca tutte quelle ricette che hanno un determinato ingrediente usando un nome
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  Searcher searchByIngredientName(String name){
    if(name==null || name=="") throw new Exception("nome non valido");
    for(Recipe recipe in cookBook.getRecipes()){//per ogni ricetta
      for(Ingredient ing in recipe.getIngredients()){//per ogni ingrediente
        if(ing is SimpleIngredient){
          if((ing as SimpleIngredient).getName()==name) list.add(recipe);
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

  Searcher searchByDifficult(int difficult){
    if(difficult==null || difficult<0) throw new Exception("Difficoltà non valida");
    list.addAll(cookBook.getRecipes().where((el)=>el.getDifficult()==difficult));
    return this;
  }

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  Searcher clear() {
    list.clear();
  }

  ///Ritorna la lista delle ricette ottenuta dalle ricerche
  Set<Recipe> getRecipes(){
    return list;
  }

  Searcher searchByExecutionTime(int houres, int minutes) {
    if(houres==null || minutes==null || houres>24 || houres<0 ||minutes>59||minutes<0) throw new Exception(" tempo non valido");
    ExecutionTime t=new ExecutionTime(houres,minutes);
    list.addAll(cookBook.getRecipes().where((el)=>el.getExecutionTime().equals(t)));
    return this;
  }

  ///Ulteriore ricerca da effettuare in seguito ad una precedente
  ///Solitamente CookBook.getRecipes().searchByIngredient(instance of ingredient).then().then().then()...
  Searcher thenByIngredient(Ingredient ingredient){
    if(ingredient==null) throw new Exception("ingrediente nullo");
    Set<Recipe> toRemove=list.where((el)=>!el.contains(ingredient)).toSet();
    list.removeAll(toRemove);
    return this;
  }

  Searcher thenByIngredients(List<Ingredient> ingredients){
    if(ingredients==null) throw new Exception("ingredienti non validi");
    Set<Recipe> toRemove=new Set<Recipe>();
    for(Ingredient ing in ingredients){
      toRemove=list.where((el)=>!el.contains(ing)).toSet();
    }
    list.removeAll(toRemove);
    return this;
  }

  Searcher thenByIngrendientName(String name){
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

  Searcher thenByDifficult(int difficult) {
    if(difficult==null || difficult<0) throw new Exception("Difficoltà non valida");
    Set<Recipe> lascia=list.where((el)=>el.getDifficult()==difficult).toSet();
    list.clear();
    list.addAll(lascia);
    return this;
  }

  Searcher thenByExecutionTime(int houres,int minutes){
    if(houres==null || minutes==null || houres>24 || houres<0 ||minutes>59||minutes<0) throw new Exception(" tempo non valido");
    ExecutionTime t=new ExecutionTime(houres,minutes);
    Set<Recipe> lascia=list.where((el)=>el.getExecutionTime().equals(t)).toSet();
    list.clear();
    list.addAll(lascia);
    return this;
  }

}