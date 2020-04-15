

import 'dart:convert';

import 'package:ricettario/studionotturno/cookbook/Level_1/resource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/executionTimeAdapter.dart';

///Implementazione del Proxy per una risorsa leggera dei dati delle ricette su firestore
class LazyResource implements Resource{

  String documentID,recipeName;
  double minutes;

  @override
  dynamic getResource() {
    return this;
  }


  Resource toObject(Map<dynamic, dynamic> data) {
    this.documentID=data['documentID'];
    this.recipeName=data['recipeName'];
    this.minutes=double.parse(data['executionTime']);//this.minutes=jsonDecode(data['executionTime']);
    return this;
  }

  @override
  Map<String,dynamic > toJson() {
    return{
      "documentID": this.documentID,
      "recipeName":this.recipeName,
      "executionTime":this.minutes
    };
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

  @override
  String toString() {
    return 'LazyResource{documentID: $documentID, recipeName: $recipeName, minutes: $minutes}';
  }


}