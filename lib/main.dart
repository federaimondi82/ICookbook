import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
    moke.saveAllRecipes();*///le salva nel file


    //Carca le lezyResources dal cloud versio il client
    //RecipeMapperSpringboot().getMapper();

    //#endregion init


    return MaterialApp(
      title: 'Cookbook',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: Colors.blueGrey[900]),
      home: Splash(2000),//CookbookPage(),
    );
  }

}