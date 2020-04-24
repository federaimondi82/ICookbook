
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';

import '../recipeMapper.dart';
import 'serviceFirestore.dart';

class RecipeMapperFirestore implements RecipeMapper{

  static final RecipeMapperFirestore _proxy= RecipeMapperFirestore._internal();
  static ServiceFirestore s;
  static List<LazyResource> lazyResources;

  RecipeMapperFirestore._internal();

  factory RecipeMapperFirestore() {
    if(lazyResources==null) {
      lazyResources = new List<LazyResource>();
      s=new ServiceFirestore();
      Future<List<LazyResource>> list=s.getAllLazyRecipeOnCloud();
      list.then((value)=>lazyResources=value);
    }
      return _proxy;
  }
  @override
  Future<List<LazyResource>> reloadProxy(){
    Future<List<LazyResource>> list=s.getAllLazyRecipeOnCloud();
    list.then((value)=>lazyResources=value);
    return Future.value(lazyResources);
  }

  @override
  List<LazyResource> getMapper(){
    return lazyResources;
  }

  @override
  String getRecipeDocument(String recipeName){
    return lazyResources.firstWhere((doc)=>doc.getRecipeName()==recipeName).getDocumentID();
  }

  ///rimuove una Entry, della mappatura tra documenti e ricette, in base al nome della ricetta
  @override
  void remove(String recipeName) {
    lazyResources.remove(getRecipeDocument(recipeName));
  }

}