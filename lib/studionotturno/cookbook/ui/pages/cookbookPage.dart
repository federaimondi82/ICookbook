

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

import 'recipePage.dart';

class CookbookPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() =>CookbookPageState();
}


class CookbookPageState extends State<CookbookPage>{

  Cookbook cookBook;

  CookbookPageState(){
    this.cookBook=new Cookbook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('My Cookbook')),
      body: RefreshIndicator(
        child: _myRecipes(context),
        onRefresh: (){
          print("refresh");
          return null;
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipePage(null)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey[900],
      ),
    );
  }

  Widget _myRecipes(BuildContext context){
    List<Widget> list = new List<Widget>();
    for(Recipe r in this.cookBook.getRecipes()){
      list.add(new ListTile(
        title: Text(r.getName().toUpperCase(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontStyle: FontStyle.italic)),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RecipePage(r)),
          );
        //TODO go to specific RecipePage
        },
        onLongPress: (){
          //mostrare il dialog _deleteRecipeDialog
          showDialog(context: context, child: _deleteRecipeDialog(context,r.getName()));
        },
        leading: const Icon(Icons.room_service,size: 40.0, color: Colors.blueGrey),
        subtitle: Text(r.getExecutionTime().toMinutes().toString()+" minutes"))
        );
    }
    return new ListView(
        children: ListTile.divideTiles(
        context: context,
        color: Colors.blueGrey,
        tiles: list
        ).toList()
    );
  }


  Widget _deleteRecipeDialog(BuildContext context,String recipeName) {
    return SimpleDialog(
      title: Text("Delete recipe",textAlign: TextAlign.center),
      titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      children: [
        Text(
          "Are you sure to delete this recipe?",
          style: TextStyle(fontSize: 20),textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: RaisedButton(
            onPressed: (){
              setState(() {
                Recipe r=this.cookBook.getRecipe(recipeName);
                this.cookBook.remove(r);
                Navigator.of(context).pop();
              });
            },
            color: Colors.blueGrey[900],
            highlightColor: Colors.lightGreenAccent,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text('DELETE',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
          ),
        ),
      ],

    );
  }
}