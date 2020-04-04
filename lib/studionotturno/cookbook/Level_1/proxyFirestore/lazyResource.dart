

import 'dart:convert';

import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/resource.dart';

///Implementazione del Proxy per una risorsa leggera dei dati delle rictte in cloud
class LazyResource implements Resource{

  String documentID,recipeName,element;
  double minutes;

  @override
  dynamic getResource() {
    return this;
  }


  Resource toObject(String documentID,Map<dynamic, dynamic> data) {
    this.documentID=documentID;
    this.recipeName=data['name'];
    this.minutes=jsonDecode(data['executionTime']);
    return this;
  }

  //#region setter

  LazyResource setDocumentID(String documentID){this.documentID=documentID; return this;}

  LazyResource setRecipeName(String recipeName){this.recipeName=recipeName; return this;}

  LazyResource setExecutionTime(double executionTime){this.minutes=executionTime; return this;}

  //#endregion setter


  //#region getter

  String getDocumentID(){return this.documentID;}

  String getRecipeName(){return this.recipeName;}

  double getExecutionTime(){return this.minutes;}

  //#endregion getter

}