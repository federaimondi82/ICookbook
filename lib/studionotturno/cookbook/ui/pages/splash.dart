

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/mokeStarter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/proxyPersonalFirestore.dart';
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
    await loadData();
    return Timer(d,route);
  }

  ///Caricmento delle ricette in locale e confronto con le ricette on cloud
  loadData() async{

    /*Mediator mediator=new Mediator();
    mediator.loadDataFromFile();*/
    MokeStarter moke=new MokeStarter();
    moke.deleteFile();//cancella il file
    moke.caricaRicette2();//carica le ricette nel ricettario
    moke.saveAllRecipes();//le salva nel file
    moke.loadCookbook();//legge dal file e carica il ricettario

    //TODO proxy
    ProxyPersonalFirestore proxy=new ProxyPersonalFirestore();
    Map<String,String> map=proxy.getMapper();

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