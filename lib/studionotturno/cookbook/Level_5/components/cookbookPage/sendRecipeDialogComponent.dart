

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/serviceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/recipeMapperSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_2/mediator.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/cookbookPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/signinPage.dart';

class SendRecipeDialogComponent extends StatefulWidget{

  BuildContext context;
  String recipeName;
  SendRecipeDialogComponent(this.context,this.recipeName);

  @override
  State<StatefulWidget> createState()=>SendRecipeDialogState(context,recipeName);

}

class SendRecipeDialogState extends State<SendRecipeDialogComponent>{

  BuildContext context;
  String recipeName;
  Cookbook _cookBook;
  ServiceCloud service;

  User user;

  static const EdgeInsetsGeometry btnPadding=EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  SendRecipeDialogState(this.context,this.recipeName){
    user=new User();
    _cookBook=new Cookbook();
    //fileManager=new FileManager();
  }



  @override
  Widget build(BuildContext context) {

    User user=new User();
    List<LazyResource> map=new List<LazyResource>();
    if(user.getName()!=null){
      RecipeMapperSpringboot proxy=new RecipeMapperSpringboot();
      map=proxy.getMapper();
    }

    return SimpleDialog(
      title: Text("SHARE or DELETE",textAlign: TextAlign.center),
      titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      children: [
        Text(
          "$recipeName?",
          style: TextStyle(fontSize: 20),textAlign: TextAlign.center,
        ),
        Padding(//share
          padding: btnPadding,
          child: RaisedButton(
            onPressed:() async{
              if(user.getName()=="" || user.getName()==null){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>SigninPage()));
              }
              else{
                service=ServicesRegister().getService("springboot").createServiceCloud();
                service.setRecipeName(recipeName);
                await service.shareRecipe();
                setState(() {
                  Navigator.of(context).pop();
                });
              }
            },
            color: Colors.blueGrey[900],
            highlightColor: Colors.lightGreenAccent,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text('Share',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
          ),
        ),
        Padding(//remove
          padding: btnPadding,
          child: RaisedButton(
            onPressed:() async {
              //TODO con ServiceCloud
              if(user.getName()=="" || user.getName()==null){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>SigninPage()));
              }
              else{
                service=ServicesRegister().getService("springboot").createServiceCloud();
                service.setRecipeName(recipeName);
                await service.remove(recipeName);
                setState(() {
                  Navigator.of(context).pop();
                });
              }
              /*service=new ServiceSpringboot();
              service.setRecipeName(recipeName);
              await service.remove(recipeName);
              setState(() {
                Navigator.of(context).pop();
              });*/
            },
            color: Colors.blueGrey[900],
            highlightColor: Colors.lightGreenAccent,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text('DELETE on cloud',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
          ),
        ),
        Padding(
          padding: btnPadding,
          child: RaisedButton(
            onPressed: (){
              setState(() {
                Recipe r=_cookBook.getRecipe(recipeName);
                _cookBook.remove(r);
                Mediator m=new Mediator();
                m.saveAllRecipes().whenComplete((){
                  this.deactivate();
                  //Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new CookbookPage()),(Route<dynamic> route) => false,);
                });

                //this.deactivate();

             });
            },
            color: Colors.blueGrey[900],
            highlightColor: Colors.lightGreenAccent,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text('DELETE in local',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
          ),
        ),
      ],

    );
  }


}