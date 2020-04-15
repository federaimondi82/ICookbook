

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/resource.dart';

import '../../../myIterator.dart';


///Un concrete iterator per gestire l'attraversamento di una collezione  e ricercare
///le ricette che hanno un determinato ingrediente
///Fa parte del patter Iterator ( concrete iterator )
///Responsabilità di cercare in una collezione di ricette tutte le ricette con un certo ingrediente
class ConcreteIteratorByIngredientFirebase implements MyIterator{

  Future<Set<Resource>> future;
  Set<Resource> set;
  String ingredientName;

  ConcreteIteratorByIngredientFirebase(Set<Resource> set,String name){
    this.set=set;
    this.ingredientName=name;
  }

  @override
  Future<Set<Resource>> get() async{
    return await searchByIngredient();
  }

  Future<QuerySnapshot> filter() async {
    Future<QuerySnapshot> future=Future.delayed(Duration(milliseconds: 200),(){
      return Firestore.instance.collection('recipes').getDocuments();
    });
    return future;

  }

  Future<Set<Resource>> searchByIngredient() async{
    QuerySnapshot q= await filter();
    Set<Resource> set1=new Set<Resource>();
    Future<Set<Resource>> future=Future.delayed(Duration(milliseconds: 100),(){
      q.documents.where((docs)=>docs.data['recipe'].toString().contains(this.ingredientName))
          .forEach((el){
        set1.add(new LazyResource().toObject(el.data));
      });
      return Future.value(set1);
    });
    return future;
  }


}