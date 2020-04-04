import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/proxyPersonalFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_2/mokeStarter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/documentAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/splash.dart';

void main()=>runApp(MyApp2());

class MyApp2 extends StatefulWidget{

  @override
  State<StatefulWidget> createState()=>MyApp();

}

class MyApp extends State<MyApp2> {
//roomservice restaurant fastfood free_breakfast cake kitcken

  @override
  void dispose() {
    //todo Mediator salva tutte le ricette
    /*FileManager c=new FileManager();
    c.saveAllRecipes();*/
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /*//tutte le ricette di un utente
    Future<List<DocumentSnapshot>> firstLevel= Firestore.instance.collection('recipes').where('userName',isEqualTo: 'federaimondi82@gmail.com')
        .getDocuments().then(((docs)=>docs.documents));
    //firstLevel.then((value)=>value.forEach((el)=>print(el.data.toString())));
    firstLevel.then((value)=>value.forEach((el){
      Recipe r=DocumentAdapter().toObject(el.data);
      print(r.toString());
    }));*/
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //#region init

    /*MokeStarter moke=new MokeStarter();
    moke.deleteFile();//cancella il file
    moke.caricaRicette2();//carica le ricette nel ricettario
    moke.saveAllRecipes();//le salva nel file*/


    //TODO proxy
    ProxyPersonalFirestore proxy=new ProxyPersonalFirestore();
    Map<String,String> map=proxy.getMapper();

    //#endregion init

    return MaterialApp(
      title: 'Cookbook',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: Colors.blueGrey[900]),
      home: Splash(2000),//CookbookPage(),
    );
  }

}