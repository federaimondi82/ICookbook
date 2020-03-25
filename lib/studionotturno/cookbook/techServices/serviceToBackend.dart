

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/proxyPersonalFirestore.dart';

import 'documentAdapter.dart';

///Classe per metter in collegamento i servizi di firebase; serve per inviare,
///modificicare,reperire,cancellare ricette in cloud
class ServiceFireStone{

  final firestore=Firestore.instance;
  String userEmail;
  String recipeName;
  Recipe recipe;
  //Map<String,String> list;
  ProxyPersonalFirestore proxy;

  ServiceFireStone(){
    //this.list=new Map<String,String>();
    this.userEmail="federaimondi82@gmail.com";
    proxy=new ProxyPersonalFirestore();
  }

  setRecipeName(String name){
    this.recipeName=name;
  }

  ///Invia una ricetta in cloud
  ///Se già presente, ossia una ricetta ha lo stesso nome, non può essere salvata di nuovo,
  ///ma viene modificata
  void shareRecipe() async{
    this.recipe=Cookbook().getRecipe(this.recipeName);

    if(proxy.getMapper().values.contains(this.recipeName)) await remove(proxy.getRecipeDocument(this.recipeName));
    await firestore.collection('recipes').document().setData(DocumentAdapter(this.recipe).toJson());
    print("saved");
  }


  ///carica una lista con tutti i nomi delle ricette dell'utente che sono memorizzare in cloud
  Future<Map<String,String>> getAllRecipeOnCloud() async{
    Map<String,String> list=new Map<String,String>();
    await firestore.collection('recipes').where('userName',isEqualTo: userEmail)
      .getDocuments().then(((docs)=>docs.documents.forEach((doc){
        list.putIfAbsent(doc.documentID, ()=>doc['recipeName'].toString());
    })));

    return Future.value(list);

  }


  ///Viene richiesto al servizio cloud FireStone una ricetta con uno specifico nome
  /*Recipe getRecipe() {
    firestore.collection('recipes').where('userName',isEqualTo: userEmail)
        .getDocuments().then(((docs)=>docs.documents.where((doc)=>doc['recipeName']==this.recipeName)
    .toList().elementAt(0)));
    return this.recipe;
  }*/

  void remove(String docToRemove) async{
    await this.firestore.collection('recipes').document(docToRemove).delete();
    proxy.remove(recipeName);
    print("removed");
  }

}