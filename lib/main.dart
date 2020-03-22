import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/cookbookLoader.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/splash.dart';

void main()=>runApp(MyApp2());

class MyApp2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>MyApp();

}

class MyApp extends State<MyApp2> {
//roomservice restaurant fastfood free_breakfast cake kitcken
  //Cookbook cookBook=new Cookbook();

  @override
  void dispose() {
    CookbookLoader c=new CookbookLoader();
    c.saveAllRecipes();
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