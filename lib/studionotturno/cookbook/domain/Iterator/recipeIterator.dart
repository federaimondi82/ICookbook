
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

abstract class RecipeIterator{


  RecipeIterator searchByRecipeName(String name){  }

  ///ricerca tutte quelle ricette che hanno un determinato ingrediente usando una istanza
  ///di tipo Ingredient.
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  RecipeIterator searchByIngredient(Ingredient ingredient){ }

  ///ricerca tutte quelle ricette che hanno un lista di ingredienti semplici
  ///al loro interno,vengono cercati gli ingredienti semplici anche in quelli composti
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  RecipeIterator searchByIngredients(List<Ingredient> ingredients){  }

  ///ricerca tutte quelle ricette che hanno un determinato ingrediente usando un nome
  ///ritorna l'istanza Searcher per permettere ricerche concatendando i metodi
  ///Una parametro di classe "list" di tipo List<Recipe>  viene riempita
  RecipeIterator searchByIngredientName(String name){ }

  RecipeIterator searchByDifficult(int difficult){ }

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  RecipeIterator clear() { }

  ///Ritorna la lista delle ricette ottenuta dalle ricerche
  Set<Recipe> getRecipes(){ }

  RecipeIterator searchByExecutionTime(int minutes) {  }

  ///Ulteriore ricerca da effettuare in seguito ad una precedente
  ///Solitamente CookBook.getRecipes().searchByIngredient(instance of ingredient).then().then().then()...
  RecipeIterator thenByIngredient(Ingredient ingredient){  }

  RecipeIterator thenByRecipeName(String name){  }

  RecipeIterator thenByIngredients(List<Ingredient> ingredients){ }

  RecipeIterator thenByIngrendientName(String name){  }

  RecipeIterator thenByDifficult(int difficult) { }

  RecipeIterator thenByExecutionTime(int minutes){  }

  RecipeIterator addDeletedRecipeName(String name);

  RecipeIterator addDeletedIngredientName(String name);

}