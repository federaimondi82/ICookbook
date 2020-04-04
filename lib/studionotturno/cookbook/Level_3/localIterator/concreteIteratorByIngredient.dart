


import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';

import 'irecipesIterator.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione  e ricercare
///le ricette che hanno un determinato ingrediente
///Fa parte del patter Iterator ( concrete iterator )
///Responsabilità di cercare in una collezione di ricette tutte le ricette con un certo ingrediente
class ConcreteIteratorByIngredient implements IRecipesIterator{

  Set<Recipe> set;
  int currentPosition=0;

  ConcreteIteratorByIngredient(Set<Recipe> set,String name){
    this.set=searchByIngredient(set,name);
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

  Set<Recipe> searchByIngredient(Set<Recipe> set,String ingredient){
    Set<Recipe> set2=new Set<Recipe>();
    set.forEach((recipe){
      recipe.getIngredients().forEach((ing){
        if(ing is SimpleIngredient && ing.getName().toString().contains(ingredient)) set2.add(recipe);
        if(ing is CompositeIngredient){
          ing.getIngredients().forEach((simple){
            if(simple.getName().toString().contains(ingredient)) set2.add(recipe);
          });
        }
      });
    });
    return set2;

  }


}