

import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/resource.dart';

///Implementazione del Proxy per una risorsa leggera dei dati delle rictte in cloud
class LazyResource implements Resource{

  String documentID,recipeName,minutes,element;

  LazyResource(String documentID,String recipeName,String executionTime){
    this.documentID=documentID;
    this.recipeName=recipeName;
    this.minutes=executionTime;
    this.element=documentID+"-"+recipeName+"-"+executionTime;
  }

  @override
  getResource() {
    return this;
  }

  //#region getter

  String getDocumentID(){return this.documentID;}

  String getRecipeName(){return this.recipeName;}

  String getExecutionTime(){return this.minutes;}

  //#endregion getter

}