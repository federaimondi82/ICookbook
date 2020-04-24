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
  loadData() async{

    Mediator mediator=new Mediator();
    await mediator.loadDataFromFile().whenComplete(() async{
      fileManager=new FileManager();
      Future<List<Map<String,dynamic>>> future= fileManager.readFileCache();

      future.then((value) => value.forEach((element) async{
        await loadCacheFile(element).then((value) async {
          if(value.getName()!=null){
            RecipeMapper mapper=ServicesRegister().getService("springboot").createMapper();
            await mapper.reloadProxy();
          }
        });
      }));
    });
  }

  Future<User> loadCacheFile(Map<String,dynamic> element)async{
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