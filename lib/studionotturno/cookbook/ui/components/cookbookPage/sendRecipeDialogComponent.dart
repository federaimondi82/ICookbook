

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/cookbookLoader.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/proxyPersonalFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/serviceToBackend.dart';

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
  static const EdgeInsetsGeometry btnPadding=EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  SendRecipeDialogState(this.context,this.recipeName){
    _cookBook=new Cookbook();
  }



  @override
  Widget build(BuildContext context) {

    ProxyPersonalFirestore proxy=new ProxyPersonalFirestore();
    Map<String,String> map=proxy.getMapper();

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
            onPressed:() async{//
                ServiceFireStone service=new ServiceFireStone();
                service.setRecipeName(recipeName);
                await service.shareRecipe();
                await setState(() {
                  Navigator.of(context).pop();
                });

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
                ServiceFireStone service=new ServiceFireStone();
                service.setRecipeName(recipeName);
                //await service.getAllRecipeOnCloud();
                await service.remove(proxy.getRecipeDocument(this.recipeName));
                //proxy.remove(this.recipeName);
                await setState(() {
                  Navigator.of(context).pop();
                });
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
                CookbookLoader loader=new CookbookLoader();
                loader.saveAllRecipes();
                Navigator.of(context).pop();
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