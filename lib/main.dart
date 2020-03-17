import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/cookbookPage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
//roomservice restaurant fastfood free_breakfast cake kitcken
  Cookbook cookBook=new Cookbook(); 


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
      home: CookbookPage(),
    );
  }

}