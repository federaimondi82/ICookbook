

import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

class RecipeIteratorCloud{

  Future<List<Recipe>> searchByRecipeName(String name){  }

  ///ricerca tutte quelle ricette che hanno un determinato ingrediente usando una istanza
  ///di tipo Ingredient.
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  Future<List<Recipe>> searchByIngredient(Ingredient ingredient){ }

  ///ricerca tutte quelle ricette che hanno un lista di ingredienti semplici
  ///al loro interno,vengono cercati gli ingredienti semplici anche in quelli composti
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  Future<List<Recipe>> searchByIngredients(List<Ingredient> ingredients){  }

  ///ricerca tutte quelle ricette che hanno un determinato ingrediente usando un nome
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  Future<List<Recipe>> searchByIngredientName(String name){ }

  Future<List<Recipe>> searchByDifficult(int difficult){ }

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  void clear() { }

  ///Ritorna la lista delle ricette ottenuta dalle ricerche
  List<Recipe> getRecipes(){ }

  Future<List<Recipe>> searchByExecutionTime(int minutes) {  }

  ///Ulteriore ricerca da effettuare in seguito ad una precedente
  ///Solitamente CookBook.getRecipes().searchByIngredient(instance of ingredient).then().then().then()...
  Future<List<Recipe>> thenByIngredient(Ingredient ingredient){  }

  Future<List<Recipe>> thenByRecipeName(String name){  }

  Future<List<Recipe>> thenByIngredients(List<Ingredient> ingredients){ }

  Future<List<Recipe>> thenByIngrendientName(String name){  }

  Future<List<Recipe>> thenByDifficult(int difficult) { }

  Future<List<Recipe>> thenByExecutionTime(int minutes){  }

}