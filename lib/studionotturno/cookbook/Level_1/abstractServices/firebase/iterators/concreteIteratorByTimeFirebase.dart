

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/resource.dart';

import '../../../myIterator.dart';

///Un concrete iterator per gestire l'attraversamento di una collezione e
///ricercare una ricetta con tempo di esecuzione al di sotto di quella impostata nel costruttore
///Fa parte del patter Iterator ( concrete iterator )
class ConcreteIteratorByTimeFirebase implements MyIterator{

  Future<Set<Resource>> future;
  Set<Resource> set;
  int time;

  ConcreteIteratorByTimeFirebase(Set<Resource> set,int time){
    this.set=set;
    this.time=time;
  }

  @override
  Future<Set<Resource>> get() async{
    return await searchByTime();
  }

  Future<QuerySnapshot> filter() async {
    Future<QuerySnapshot> future=Future.delayed(Duration(milliseconds: 200),(){
      return Firestore.instance.collection('recipes')
          .where('executionTime',isGreaterThan: this.time).getDocuments();
    });
    return future;

  }

  Future<Set<Resource>> searchByTime() async{
    QuerySnapshot q= await filter();
    Set<Resource> set1=new Set<Resource>();
    Future<Set<Resource>> future=Future.delayed(Duration(milliseconds: 100),(){
      q.documents.where((docs)=>docs.data['recipe']['executionTime'].toString().contains(this.time.toString()))
          .forEach((el){
        set1.add(new LazyResource().toObject(el.data));
      });
      return Future.value(set1);
    });
    return future;
  }
}