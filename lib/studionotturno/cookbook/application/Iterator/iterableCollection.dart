

import 'recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

///Interfaccia che definisce i metodi creatori degli iteratori completi per la collezione delle ricette ( un cookbook )
///Implementata nella classe Cookbook consete di iterare sulla collezione di ricette.
///Fa parte del design patter Iterator (IterableCollection).
abstract class IterableCollection {

  ///permette la creazione di un iteratore per nome sulla collezione di ricette
  RecipesIterator createIteratorByName(Set<Recipe> set,String name);
  ///permette la creazione di un iteratore per ingredient sulla collezione di ricette
  RecipesIterator createIteratorByIngredient(Set<Recipe> set,String ingredientName);
  ///permette la creazione di un iteratore per tempo di esecuzione sulla collezione di ricette
  RecipesIterator createIteratorByTime(Set<Recipe> set,int minutes);
  ///permette la creazione di un iteratore per difficoltà sulla collezione di ricette
  RecipesIterator createIteratorByDifficult(Set<Recipe> set,int difficult);
  ///permette la creazione di un iteratore per ritorn una collezionein ordine alfabetico
  RecipesIterator createIteratorAscending(Set<Recipe> set);

}