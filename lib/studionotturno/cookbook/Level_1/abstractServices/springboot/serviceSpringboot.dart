

import 'dart:convert';

import 'package:http/http.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/documentAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';

///Servizio di basso livello per collegarsi al backend Springboot
class ServiceSpringboot implements ServiceCloud{

  String url,recipeName;
  Recipe recipe;
  User user;

  ServiceSpringboot(){
    //this.url="http://10.0.2.2:8080";
    this.url="http://localhost:8080";
    this.user=new User();
  }

  @override
  ServiceCloud setRecipeName(String name) {
    this.recipeName=name;
    return this;
  }
  @override
  String getUrl(){
    return this.url;
  }

  @override
  Future<bool> shareRecipe() async{
    this.recipe=Cookbook().getRecipe(this.recipeName);
    Map<String,dynamic> docu=DocumentAdapter().setUserName().setRecipe(this.recipe).toJson();
    Response response = await post(this.url+"/docu/post_documents/", body: jsonEncode(docu));
    if(response.statusCode==200){
      String result=response.body.toString();
      bool resultBool=false;
      if(result=="true") resultBool=true;
      return Future.value(resultBool);
    }else return Future.value(false);
  }

  @override
  Future<List<LazyResource>> getAllLazyRecipeOnCloud() async {
    Response response = await get(this.url+"/docu/get_documents/"+this.user.getEmail());
    if(response.statusCode==200){
      List<dynamic> json = jsonDecode(response.body);
      List<LazyResource> list=new List<LazyResource>();
      json.forEach((doc){
        list.add(new LazyResource().setDocumentID(doc["_id"]).setRecipeName(doc['recipeName'].toString()).setExecutionTime(doc['executionTime']));
      });
      return Future.value(list);
    }else return Future.value(null);

  }

  @override
  Future<bool> remove(String docToRemove)async {
    Response response =await delete(this.url+"/docu/delete_documents/"+this.user.getEmail()+"/"+docToRemove);
    if(response.statusCode==200){
      String result=response.body.toString();
      bool resultBool=false;
      if(result=="true") resultBool=true;
      return Future.value(resultBool);
    }else return Future.value(false);
  }

  @override
  Future<List<Recipe>> getAllRecipeOnCloud() async {
    Response response = await get(this.url+"/docu/get_documents/"+this.user.getEmail());
    if(response.statusCode==200){
      List<dynamic> json = jsonDecode(response.body);
      List<Recipe> list=new List<Recipe>();
      json.forEach((doc){
        list.add(DocumentAdapter().toObject((doc as Map<String,dynamic>)));
      });
      return Future.value(list);
    }else return Future.value(null);
  }

  @override
  Future<String> retrieveDocumentID()async{
    Response response =await get(this.url+"/docu/get_documents/recipes/"+this.user.getEmail()+"/"+this.recipeName);
    if(response.statusCode==200){
      return Future.value(response.body.toString());
    }else return Future.value(null);
  }

  @override
  Future<List<LazyResource>> findRecipes(List<LazyResource> list,String element,int opt)async{
    String url="";
    switch(opt){
      case 0:url="/docu/iterator/byName/";break;
      case 1:url="/docu/iterator/byIngredient/";break;
      case 2:url="/docu/iterator/byExecutionTime/";break;
      case 3:url="/docu/iterator/byDifficult/";break;
      case 4:url="/docu/iterator/byTotalTags/";break;
    }
    Response response =await post(this.url+url+element,body: jsonEncode(<String,List<dynamic>>{"res":list,}));
    if(response.statusCode==200){
      List<dynamic> json = await jsonDecode(response.body);
      List<LazyResource> lazyListResponse=new List<LazyResource>();
      json.forEach((doc){
        lazyListResponse.add(LazyResource().toObject(doc));
      });
      return Future.value(lazyListResponse);
    }else return Future.value(null);
  }

  @override
  Future<bool> sendData(Object object, String url) async{
    Response response =await post(this.url+url,body: jsonEncode(<String,dynamic>{"data":object,}));
    if(response.statusCode==200){
      bool json = await jsonDecode(response.body);
      return Future.value(json);
    }else return Future.value(null);
  }

  ///Consente di recuperare i dati dell'utente nella fase di login/registrazione
  Future<User> retrieveData(Object object,String url)async{
    Response response =await post(this.url+url,body: jsonEncode(<String,dynamic>{"data":object,}));
    if(response.statusCode==200){
      Map<String,dynamic> json = await jsonDecode(response.body);
      User u=new User();
      return Future.value(UserAdapter().setUser(u).toObject(json));
    }else{
      print("errore");
      return Future.value(null);
    }
  }

}