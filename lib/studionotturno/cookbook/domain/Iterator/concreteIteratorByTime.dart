

import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione e
///ricercare una ricetta con tempo di esecuzione al di sotto di quella impostata nel costruttore
///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorByTime implements RecipesIterator{

  Set<Recipe> set;
  int currentPosition=0;

  ConcreteIteratorByTime(Set<Recipe> set,int minutes){
    this.set=searchByTime(set,minutes);
  }

  @override
  bool hasNext() {
    return this.currentPosition<set.length;
  }

  @override
  Recipe next() {
    if(hasNext()) return this.set.elementAt(this.currentPosition++);
    return null;
  }

  @override
  void reset() {
    this.currentPosition=0;
  }

  Set<Recipe> searchByTime(Set<Recipe> set,int minutes){
    return set.where((recipe)=>recipe.getExecutionTime().toMinutes()<=minutes).toSet();
  }
}