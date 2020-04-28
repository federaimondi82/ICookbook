

import 'dart:convert';

import 'package:http/http.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_2/mediator.dart';
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
  Mediator med;

  ServiceSpringboot(){
    this.url="http://10.0.2.149:8080";//IP rete LAN
    //this.url="http://10.0.2.2:8080";//per emulatore
    //this.url="http://localhost:8080";//per cellulare e test di integrazione
    this.user=new User();
    this.med=new Mediator();
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
    bool resultBool=false;
    Map<String,dynamic> docu=DocumentAdapter().setUserName().setRecipe(this.recipe).toJson();
    this.med.loadJWT().then((value) async {
      Response response = await post(this.url+"/docu/post_documents/", body: jsonEncode(docu),headers:value);
      if(response.statusCode==200){
        String result=response.body.toString();
        if(result=="true") resultBool=true;
      }
    });
    return Future.value(resultBool);
  }

  @override
  Future<List<LazyResource>> getAllLazyRecipeOnCloud() async {
    List<LazyResource> list=new List<LazyResource>();
    this.med.loadJWT().then((value) async {
      Response response = await get(this.url+"/docu/get_documents/lazy",headers: value);
      if(response.statusCode==200){
        List<dynamic> json = jsonDecode(response.body);
        json.forEach((doc)=>list.add(new LazyResource().toObject(doc)));
      }
    });
    return Future.value(list);
  }

  @override
  Future<bool> remove(String recipeName)async {
    bool resultBool=false;
    this.med.loadJWT().then((value) async {
      Response response =await post(this.url+"/docu/delete_documents/",
          body: jsonEncode(<String,dynamic>{"recipeName":recipeName}),headers:value);
      if(response.statusCode==200){
        String result=response.body.toString();
        if(result=="true") resultBool=true;
      }
    });
    return Future.value(resultBool);
  }

  @override
  Future<List<Recipe>> getAllRecipeOnCloud() async {
    List<Recipe> list=new List<Recipe>();
    this.med.loadJWT().then((value) async {
      Response response = await get(this.url+"/docu/get_documents/",headers: value);
      if(response.statusCode==200){
        List<dynamic> json = jsonDecode(response.body);
        json.forEach((doc){
          list.add(DocumentAdapter().toObject((doc as Map<String,dynamic>)));
        });
      }
    });
    return Future.value(list);
  }

  @override
  Future<String> retrieveDocumentID()async{
    String res="";
    this.med.loadJWT().then((value) async {
      Response response =await get(this.url+"/docu/get_documents/recipes/"+this.recipeName,headers: value);
      if(response.statusCode==200) res=response.body.toString();
    });
    return Future.value(res);
  }

  @override
  Future<List<LazyResource>> findRecipes(List<LazyResource> inputList,String element,int opt)async{
    String url="";
    List<LazyResource> list=new List<LazyResource>();
    switch(opt){
      case 0:url="/docu/iterator/byName/";break;
      case 1:url="/docu/iterator/byIngredient/";break;
      case 2:url="/docu/iterator/byExecutionTime/";break;
      case 3:url="/docu/iterator/byDifficult/";break;
      case 4:url="/docu/iterator/byTotalTags/";break;
    }
    this.med.loadJWT().then((value) async {
      Response response =await post(this.url+url,
          body: jsonEncode(<String,dynamic>{"res":inputList,"element":element,}),headers: value);
      if(response.statusCode==200){
        List<dynamic> json = jsonDecode(response.body);
        json.forEach((doc)=>list.add(new LazyResource().toObject(doc)));
      }
    });
    return Future.value(list);
  }

  @override
  Future<bool> sendData(Object object, String url) async{
    Response response;
    bool res=false;
   if(url.contains("registration")){
     response =await post(this.url+url,body: jsonEncode(<String,dynamic>{"data":object}));
   }
   else{
     this.med.loadJWT().then((value) async {
       response =await post(this.url+url,body: jsonEncode(<String,dynamic>{"data":object}),headers: value);
     });
   }
   if(response.statusCode==200){
     bool res = await jsonDecode(response.body);
   }
    return Future.value(res);
  }

  ///Consente di recuperare i dati dell'utente nella fase di login/registrazione
  Future<User> retrieveData(Object object,String url)async{
    this.med.loadJWT().then((value) async {
      Response response =await post(this.url+url,body: jsonEncode(<String,dynamic>{"data":object,}),headers: value);
      if(response.statusCode==200){
        Map<String,dynamic> json = await jsonDecode(response.body);
        User u=new User();
        return Future.value(UserAdapter().setUser(u).toObject(json));
      }else return Future.value(null);
    });
    return Future.value(null);
  }

  ///Consente di inviare i dati per il primo login e recuperare il token
  Future<String> retrieveToken(Object object,String url)async{
      Response response =await post(this.url+url,encoding: Encoding.getByName("utf-8"),
          body: jsonEncode(<String,dynamic>{"data":object,}));
      if(response.statusCode==200){
        String token=response.headers.entries.firstWhere((element) => element.key=="token").value;
        return Future.value(token);
      }else return Future.value("");
  }

}