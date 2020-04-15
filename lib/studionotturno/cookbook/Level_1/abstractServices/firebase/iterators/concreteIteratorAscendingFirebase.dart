
import 'package:ricettario/studionotturno/cookbook/Level_1/resource.dart';

import '../../../myIterator.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione riceracre
///elementi al di sotto di un determinata difficoltà

///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorAscendingFirebase implements MyIterator{

  Set<Resource> set;
  int currentPosition=0;

  ConcreteIteratorAscendingFirebase(Set<Resource> set){
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

  Set<Resource> reorderAscending(Set<Resource> set){
    //TODO
    return null;
  }

  @override
  Future<Set<Resource>> get() {
    // TODO: implement get
    return null;
  }

}