

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/recipeAdapter.dart';

///Classe per metter in collegamento i servizi di firebase; serve per inviare,
///modificicare,reperire,cancellare ricette in cloud
class ServiceFireStone{

  final firestore=Firestore.instance;
  String userID;
  String recipeName;
  Recipe recipe;
  List<String> list;

  ServiceFireStone(/*this.recipeName*/){
    //this.cookbook=new Cookbook();
    this.list=new List<String>();
    this.userID="Federico Raimondi";
  }

  setRecipeName(String name){
    this.recipeName=name;
  }

  ///Invia una ricetta in cloud
  ///Se già presente, ossia una ricetta ha lo stesso nome, non può essere salvata di nuovo,
  ///ma viene modificata
  void shareRecipe() async{
    this.recipe=Cookbook().getRecipe(this.recipeName);
    bool trovato=false;
    await isPresent(this.recipeName).then((value)=>trovato=value);
    if(trovato){
      //TODO l'utente deve modificare la ricetta in cloud
       await firestore.collection(userID).document(this.recipeName)
          .updateData(RecipeAdapter().setRecipe(this.recipe).toJson());
      print("ricetta modificata");
    }else{
      await firestore.collection(userID).document(this.recipeName)
          .setData(RecipeAdapter().setRecipe(this.recipe).toJson());
      print("ricetta salvata");
    }
  }

  ///carica una lista con tutti i nomi delle ricette dell'utente che sono memorizzare in cloud
  void getAllRecipeOnCloud() async{
    if(this.list.isNotEmpty) this.list.clear();

    await this.firestore.collection(this.userID).getDocuments().then((value){
      value.documents.forEach((doc){
        //print(doc.data['name']);
        this.list.add(doc.data['name'].toString());
      });
    });

  }

  ///Effettua un controllo in cloude per sapere se la ricetta è stata salvata
  ///Il metodo imposta una variable di classe reperibile dal " metodo exists() " di questa stessa classe
  Future<bool> isPresent(String name) async {
     bool trovato=false;
     for(String s in this.list){
       if(s==name) trovato=true;
     }
     //String s=name+"-"+trovato.toString();
    // print(s);
     Future<bool> f=Future.value(trovato);
     f.then((value)=>print(value));
     return f;
  }


  ///Viene richiesto al servizio cloud FireStone una ricetta con uno specifico nome
  Recipe getRecipe() {
    bool trovato=false;
    isPresent(this.recipeName).then((value)=>trovato=value);
    if(trovato){
      DocumentReference doc=this.firestore.collection(this.userID).document(this.recipeName);
       doc.snapshots().forEach((el)=>this.recipe=RecipeAdapter().toObject(el.data));
    }
    return this.recipe;
  }

  void remove() async{
    bool trovato=false;
    await isPresent(this.recipeName).then((value)=>trovato=value);
    print(trovato);
    if(trovato){
      //TODO cancella in cloud
      await this.firestore.collection(this.userID).document(this.recipeName).delete();
    }
    else{
      //TODO notifica che non è possibile cancellare
      print("non si cancella una cosa che non c'è");
    }
  }


}