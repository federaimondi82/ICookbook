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
  User user;

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
  ///Vengono caricate le ricette memorizzata in un file di testo in locale;
  ///una volta completato il caricamento vengono caricate le informazioni eventualmente
  ///memorizzate riguardo all'utente e al token jwt
  loadData() async{
    Mediator mediator=new Mediator();
    fileManager=new FileManager();
    RecipeMapper mapper=ServicesRegister().getService("springboot").createMapper();

    await mediator.loadDataFromFile().whenComplete(() async{
      await mediator.loadJWT().whenComplete(() async {
        RecipeMapper mapper=ServicesRegister().getService("springboot").createMapper();
        await mapper.reloadProxy().whenComplete((){
          fileManager.readFileCache().then((value){
            if(value.isNotEmpty)loadUserFromFile(value.first);
          }).whenComplete(() async => await mapper.reloadProxy());
        });
      });
    });
  }

  Future<User> loadUserFromFile(Map<String,dynamic> element)async{
    user=new User();
    user=UserAdapter().setUser(user).toObject(element);
    return user;
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