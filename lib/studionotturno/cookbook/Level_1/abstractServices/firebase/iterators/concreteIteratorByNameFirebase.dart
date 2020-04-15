
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/resource.dart';

import '../../../myIterator.dart';

///Concrete Iterator dei dati in cloud. (Pattern GOF iterator).
///Una volta istanziato l'oggetto ConcreteIteratorByNameCloud viene
/// effettuata una query nel database Firestore.
class ConcreteIteratorByNameFirebase implements MyIterator{

  Future<Set<Resource>> future;
  Set<Resource> set;
  String name;

  ConcreteIteratorByNameFirebase(String name){
    this.set=new Set<Resource>();
    this.name=name;
  }

  @override
  Future<Set<Resource>> get() async{
    return Firestore.instance.collection('recipes').getDocuments().then((value){
      value.documents.forEach((el){
        if(el.data['recipeName'].toString().contains(this.name)){
          this.set.add(new LazyResource().setDocumentID(el.documentID).setRecipeName(el.data['recipeName']).setExecutionTime(el.data['executionTime']));
        }

      });
    }).then((_)=>Future.value(this.set));
  }

  Future<QuerySnapshot> searchByName() async{
    return Firestore.instance.collection('recipes').getDocuments();
  }

  ConcreteIteratorByNameFirebase setTheSet(Set<Resource> set) {
    this.set=set;
    return this;
  }

  Set<Resource> getSet() {
    return this.set.where((el)=>(el as LazyResource).getRecipeName().contains(this.name)).toSet();
  }

}