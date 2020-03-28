import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/splash.dart';

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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Cookbook',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primaryColor: Colors.blueGrey[900]),
      home: Splash(2000),//CookbookPage(),
    );
  }

}