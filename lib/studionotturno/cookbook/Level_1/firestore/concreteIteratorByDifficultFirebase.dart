
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/resource.dart';
import 'iFirestoreIterator.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione riceracre
///elementi al di sotto di un determinata difficoltà

///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorByDifficultFirebase implements IFirestoreIterator{

  Set<Resource> set;
  int currentPosition=0;

  ConcreteIteratorByDifficultFirebase(Set<Resource> set,int difficult){
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

  Set<Resource> searchByDifficult(Set<Resource> set,int difficult){
    //TODO
    return null;
  }

  @override
  Future<Set<Resource>> get() {
    // TODO: implement get
    return null;
  }

}