

import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';

import 'irecipesIterator.dart';

///Interfaccia che definisce i metodi creatori degli iteratori completi per la collezione delle ricette ( un cookbook )
///Implementata nella classe Cookbook consete di iterare sulla collezione di ricette.
///Fa parte del design patter Iterator (IterableCollection).
abstract class IterableCollection {

  ///permette la creazione di un iteratore per nome sulla collezione di ricette
  IRecipesIterator createIteratorByName(Set<Recipe> set,String name);
  ///permette la creazione di un iteratore per ingredient sulla collezione di ricette
  IRecipesIterator createIteratorByIngredient(Set<Recipe> set,String ingredientName);
  ///permette la creazione di un iteratore per tempo di esecuzione sulla collezione di ricette
  IRecipesIterator createIteratorByTime(Set<Recipe> set,int minutes);
  ///permette la creazione di un iteratore per difficoltà sulla collezione di ricette
  IRecipesIterator createIteratorByDifficult(Set<Recipe> set,int difficult);
  ///permette la creazione di un iteratore per ritorn una collezionein ordine alfabetico
  IRecipesIterator createIteratorAscending(Set<Recipe> set);

}