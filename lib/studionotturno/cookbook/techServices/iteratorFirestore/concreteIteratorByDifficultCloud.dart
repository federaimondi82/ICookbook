
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/iteratorFirestore/firestoreDataIterator.dart';

import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/resource.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione riceracre
///elementi al di sotto di un determinata difficoltà

///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorByDifficultCloud implements FirestoreDataIterator{

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
  Resource next() {
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