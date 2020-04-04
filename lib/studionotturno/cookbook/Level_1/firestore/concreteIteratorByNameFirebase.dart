
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/resource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/documentAdapter.dart';
import 'iFirestoreIterator.dart';

///Concrete Iterator dei dati in cloud. (Pattern GOF iterator)
///Una volta istanziato loggetto ConcreteIteratorByNameCloud viene effettuata una query nel database Firestore.
class ConcreteIteratorByNameFirebase implements IFirestoreIterator{

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

/*//tute le ricette
    Firestore.instance.collection('recipes').where('name',isEqualTo: 'pizza')
        .getDocuments().then((docs)=>docs.documents.forEach((doc) async {
          //stampa tutti i dati del primo livello
       print(doc.data.toString());
          //cerca gli ingredienti semplici e composti
          await doc.reference.collection('ingredients').getDocuments()
          .then((ings) =>ings.documents.forEach((ing) async {

            //se l'ingredient è composto
            if(ing.data['isSimple']==false){
              //ogni ingrediente semplice nel composto ha il proprio documento
              await ing.reference.collection('simpleIngredient').getDocuments()
                    //per ogni ingrediente semplice viene stampato il dato
                  .then((simple)=>simple.documents.forEach((simple2)  {
                     print(simple2.data.toString());
              }));
            }
            //stampa i dati superficiali dei semplici e dei composti
            print(ing.data.toString());
          }));
    }));*/