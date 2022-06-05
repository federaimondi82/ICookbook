

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import '../../pages/simpleIngredientPage.dart';

class SimpleIngredientsListView extends StatefulWidget{

  Recipe recipe;
  BuildContext context;

  SimpleIngredientsListView(this.context,this.recipe);

  @override
  State<StatefulWidget> createState()=>SimpleIngredientsListViewState(this.context,this.recipe);

}

class SimpleIngredientsListViewState extends State<SimpleIngredientsListView>{

  Recipe recipe;
  BuildContext context;
  SimpleIngredientsListViewState(this.context,this.recipe);

  static const TextStyle textStyle = TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.purple);

  @override
  Widget build(context) {
    // TODO: implement build
    List<Widget> list = new List<Widget>();
    for(Ingredient simple in this.recipe.getIngredients()){
      if(simple is SimpleIngredient){
        list.add(new ListTile(
          title: Text(simple.getName().toUpperCase(),style:textStyle),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SimpleIngredientPage(this.recipe.getName(),null,simple)),
            );
            //TODO go to specific RecipePage
          },
          onLongPress: (){
            showDialog(
              context: context,
              builder: (context){
                return _simpleDialog(context,simple.getName());
              }
            );
          },
          trailing: const Icon(Icons.plus_one,size: 40.0, color: Colors.purple),
          subtitle: Text(simple.getAmount().getAmount().round().toString()+' '+simple.getAmount().getUnit().getAcronym().toString().toLowerCase(),style: textStyle,),
        ));
      }

    }
    return new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: ListTile.divideTiles(
            context: context,
            color: Colors.blueGrey,
            tiles: list
        ).toList()
    );
  }

  Widget _simpleDialog(context,String ingredientName) {
    return SimpleDialog(
      title: Text("Remove ingredient",textAlign: TextAlign.center),
      titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      children: [
        Text(
          "Are you sure to remove $ingredientName from "+this.recipe.getName()+"?",
          style: TextStyle(fontSize: 20),textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: RaisedButton(
            onPressed: (){
              setState(() {
                this.recipe.removeByName(ingredientName);
                Navigator.of(context).pop();
              });
            },
            color: Colors.blueGrey[900],
            highlightColor: Colors.lightGreenAccent,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text('REMOVE',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
          ),
        ),
      ],

    );
  }

}