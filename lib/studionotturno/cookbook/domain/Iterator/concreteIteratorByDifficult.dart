
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione riceracre
///elementi al di sotto di un determinata difficoltà

///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorByDifficult implements RecipesIterator{

  Set<Recipe> set;
  int currentPosition=0;

  ConcreteIteratorByDifficult(Set<Recipe> set,int difficult){
    this.set=searchByDifficult(set,difficult);
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

  Set<Recipe> searchByDifficult(Set<Recipe> set,int difficult){
    return set.where((recipe)=>recipe.getDifficult()<=difficult).toSet();
  }

}