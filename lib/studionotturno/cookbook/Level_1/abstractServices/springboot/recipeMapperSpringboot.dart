

import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/serviceSpringboot.dart';
import '../../lazyResource.dart';

class RecipeMapperSpringboot implements RecipeMapper{


  static final RecipeMapperSpringboot _proxy= RecipeMapperSpringboot._internal();
  static ServiceSpringboot s;
  static List<LazyResource> lazyResources;

  RecipeMapperSpringboot._internal();

  factory RecipeMapperSpringboot() {
    //TODO
    if(lazyResources==null) {
      lazyResources = new List<LazyResource>();
      s=new ServiceSpringboot();
      Future<List<LazyResource>> list=s.getAllLazyRecipeOnCloud();
      list.then((value)=>lazyResources=value);
    }
    return _proxy;
  }
  @override
  void reloadProxy(){
    //TODO
    Future<List<LazyResource>> list=s.getAllLazyRecipeOnCloud();
    list.then((value)=>lazyResources=value);
  }

  @override
  List<LazyResource> getMapper(){
    //TODO
    return lazyResources;
  }

  @override
  String getRecipeDocument(String recipeName){
    //TODO
    return lazyResources.firstWhere((doc)=>doc.getRecipeName()==recipeName).getDocumentID();
  }

  ///rimuove una Entry, della mappatura tra documenti e ricette, in base al nome della ricetta
  @override
  void remove(String recipeName) {
    //TODO//TODO
    lazyResources.remove(getRecipeDocument(recipeName));
  }

}