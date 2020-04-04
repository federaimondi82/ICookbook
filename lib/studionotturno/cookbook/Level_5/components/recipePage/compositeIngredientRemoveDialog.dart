
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/recipePage.dart';

class CompositeIngredientRemoveDialog extends StatefulWidget{

  BuildContext context;
  String ingredientName;
  Recipe recipe;
  CompositeIngredientRemoveDialog(this.context,this.recipe,this.ingredientName);
  @override
  State<StatefulWidget> createState()=>DialogState(this.context,this.recipe,this.ingredientName);

}

class DialogState extends State<CompositeIngredientRemoveDialog>{

  BuildContext context;
  String ingredientName;
  Recipe recipe;
  DialogState(this.context,this.recipe,this.ingredientName);

  static const EdgeInsetsGeometry pad=EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  @override
  Widget build(context) {
    return SimpleDialog(
      title: Text("Remove ingredient",textAlign: TextAlign.center),
      titlePadding: pad,
      contentPadding: pad,
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
          padding: pad,
          child: RaisedButton(
            onPressed: (){
              setState(() {
                this.recipe.removeByName(ingredientName);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipePage(this.recipe)),
                );
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