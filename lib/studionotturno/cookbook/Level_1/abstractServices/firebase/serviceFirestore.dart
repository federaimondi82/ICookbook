

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/recipeMapperFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/jwtToken.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/documentAdapter.dart';


///Classe per mettere in collegamento i servizi di firebase con l'applicazione;
/// serve per condividere, modificicare, reperire, cancellare ricette in cloud firestore
/// di firebase.
/// Non gestisce le immagini delle ricette in storage firebase
class ServiceFirestore implements ServiceCloud{

  final firestore=Firestore.instance;
  String userEmail, recipeName;
  Recipe recipe;
  RecipeMapperFirestore proxy;

  ServiceFirestore(){
    this.userEmail="federaimondi82@gmail.com";
    proxy=new RecipeMapperFirestore();
  }

  @override
  ServiceCloud setRecipeName(String name){
    this.recipeName=name;
    return this;
  }
  @override
  String getUrl(){
    return null;
  }

  @override
  Future<bool> shareRecipe() async{
    //TODO controllare con la nuova implementazione del future
    this.recipe=Cookbook().getRecipe(this.recipeName);

    if(proxy.getMapper().contains(this.recipeName)) await remove(proxy.getRecipeDocument(this.recipeName));
    await firestore.collection('recipes').document().setData(DocumentAdapter().setUserName().setRecipe(this.recipe).toJson());
  }

  @override
  Future<List<LazyResource>> getAllLazyRecipeOnCloud() async{
    List<LazyResource> list=new List<LazyResource>();
    await firestore.collection('recipes').where('userName',isEqualTo: userEmail)
      .getDocuments().then(((docs)=>docs.documents.forEach((doc){
        list.add(new LazyResource()
            .setDocumentID(doc.documentID)
            .setRecipeName(doc['recipeName'].toString())
            .setExecutionTime(double.parse(doc['executionTime'])));
    })));
    return Future.value(list);
  }

  @override
  Future<bool> remove(String docToRemove) async{
    //TODO controllare con la nuova implementazione del future
    await this.firestore.collection('recipes').document(docToRemove).delete();
    proxy.remove(recipeName);
    //print("removed");
  }

  @override
  Future<List<Recipe>> getAllRecipeOnCloud() async{
    List<Recipe> list=new List<Recipe>();
    await firestore.collection('recipes').where('userName',isEqualTo: userEmail)
        .getDocuments().then(((docs)=>docs.documents.forEach((doc){
          list.add(DocumentAdapter().toObject(doc.data));
    })));
    return Future.value(list);
  }

  @override
  Future<String> retrieveDocumentID() async{
    if(this.recipeName==null) throw new Exception("nome ricetta non presente");
    User u=new User();
    if(u.getEmail()==null) throw new Exception("utente non autenticato");
    String documentID;

    return firestore.collection('recipes').where('userName',isEqualTo: u.getEmail())
        .where('recipeName',isEqualTo: this.recipeName).limit(1)
        .getDocuments().then((docs){
      docs.documents.forEach((doc)=>documentID=doc.documentID);
    }).whenComplete(()=>Future.delayed(new Duration(milliseconds: 50),(){
      Future.value(documentID);
    }));
  }

  @override
  Future<List<LazyResource>> findRecipes(List<LazyResource> list, String element, int opt) {
    // TODO: implement findRecipes
    return null;
  }

  @override
  Future<bool> sendData(Object object, String url) {
    // TODO: implement sendData
    throw UnimplementedError();
  }

}