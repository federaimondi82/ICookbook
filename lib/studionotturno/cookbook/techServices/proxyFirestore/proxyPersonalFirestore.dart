


import 'package:ricettario/studionotturno/cookbook/foundation/serviceFirestore.dart';

class ProxyPersonalFirestore{

  static final ProxyPersonalFirestore _proxy= ProxyPersonalFirestore._internal();
  static ServiceFirestore s;
  static Map<String,String> documentsName;

  ProxyPersonalFirestore._internal();

  factory ProxyPersonalFirestore(){
    if(documentsName==null) {
      documentsName = new Map<String,String>();
      s=new ServiceFirestore();
      Future<Map<String,String>> list=s.getAllRecipeOnCloud();
      list.then((value)=>documentsName=value);
    }
      return _proxy;
  }

  void reloadProxy(){
    Future<Map<String,String>> list=s.getAllRecipeOnCloud();
    list.then((value)=>documentsName=value);
  }


  Map<String,String> getMapper(){
    return documentsName;
  }

  String getRecipeDocument(String recipeName){
    return documentsName.entries.firstWhere((doc)=>doc.value==recipeName).key;
  }

  ///rimuove una Entry, della mappatura tra documenti e ricette, in base al nome della ricetta
  void remove(String recipeName) {
    documentsName.remove(getRecipeDocument(recipeName));
  }

}