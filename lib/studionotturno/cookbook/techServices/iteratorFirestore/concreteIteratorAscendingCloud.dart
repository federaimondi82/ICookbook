
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'firestoreDataIterator.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/resource.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione riceracre
///elementi al di sotto di un determinata difficoltà

///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorAscendingCloud implements FirestoreDataIterator{

  Set<Recipe> set;
  int currentPosition=0;

  ConcreteIteratorAscending(Set<Recipe> set){
    this.set=reorderAscending(set);
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

  Set<Recipe> reorderAscending(Set<Recipe> set){
    set.toList().sort((a,b)=>a.getName().compareTo(b.getName()));
    return set.toSet();
  }

}