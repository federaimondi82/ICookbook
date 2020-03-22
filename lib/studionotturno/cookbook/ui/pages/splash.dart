

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/cookbookLoader.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/serviceToBackend.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/cookbookPage.dart';


///Una pagina iniziale per consentire la sincronizzaizone dei dati tra locale e
///le ricette pubblicate in cloud
class Splash extends StatefulWidget{
  int timeMillisecond;

  Splash(this.timeMillisecond);
  @override
  State<StatefulWidget> createState()=>new SplashState(timeMillisecond);
}

class SplashState extends State<Splash>{

  int timeMillisecond;
  @override
  void initState(){
    super.initState();
    startTimer();
  }

  SplashState(int timeMillisecond){
    this.timeMillisecond=timeMillisecond;
  }

  startTimer() async{
    var d=Duration(milliseconds: this.timeMillisecond);
    await loadRecipes();
    return Timer(d,route);
  }

  ///Caricmento delle ricette in locale e confronto con le ricette on cloud
  loadRecipes() async{

    Cookbook cookBook=new Cookbook();
    CookbookLoader loader=new CookbookLoader();
    loader.read();
    //loader.caricaRicette2();

    ServiceFireStone service=new ServiceFireStone();
    await service.getAllRecipeOnCloud();

    for(Recipe ele in cookBook.getRecipes()){
      bool trovato=false;
      await service.isPresent(ele.getName()).then((value)=>trovato=value);
      await ele.setTrovato(trovato);
    }


  }

  route(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => CookbookPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Cookbook",style:TextStyle(fontSize: 20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 10,
                ),
              ),
            ],
          ),
        ),
    );
  }



}