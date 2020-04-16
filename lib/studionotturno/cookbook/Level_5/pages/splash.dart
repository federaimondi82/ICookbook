import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_2/mediator.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';
//import 'package:ricettario/studionotturno/cookbook/Level_2/mokeStarter.dart';
//import 'package:ricettario/studionotturno/cookbook/Level_2/proxyFirestore/recipeMapperFirestore.dart';

import 'cookbookPage.dart';


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
  FileManager fileManager;
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
    await loadData();
    return Timer(d,route);
  }

  ///Caricmento delle ricette in locale e confronto con le ricette on cloud
  loadData() async{

    Mediator mediator=new Mediator();
    mediator.loadDataFromFile().whenComplete((){
      print("2");
      fileManager=new FileManager();
      Future<List<Map<String,dynamic>>> future= fileManager.readFileCache();
      User u2=new User();
      future.then((value) => value.forEach((element) {
        u2=UserAdapter().setUser(u2).toObject(element);
      }));

      if(u2.getName()!=null){
        RecipeMapper mapper=ServicesRegister().getService("springboot").createMapper();
        mapper.reloadProxy();
      }
    });

    /*MokeStarter moke=new MokeStarter();
    moke.deleteFile();//cancella il file
    moke.caricaRicette2();//carica le ricette nel ricettario
    moke.saveAllRecipes();//le salva nel file
    moke.loadCookbook();//legge dal file e carica il ricettario*/

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
              Text("ICookbook",style:TextStyle(fontSize: 20)),
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