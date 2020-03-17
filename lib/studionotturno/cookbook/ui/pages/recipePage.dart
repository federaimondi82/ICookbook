

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/ui/components/compositeIngredientExpansion.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/cookbookPage.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/simpleIngredientPage.dart';

import 'compositeIngredientPage.dart';


class RecipePage extends StatefulWidget{

  Recipe recipe;

  RecipePage(Recipe recipe){
    if(recipe==null)this.recipe=new Recipe("");
    else this.recipe=recipe;
  }

  @override
  State<StatefulWidget> createState() => RecipePageState(this.recipe);
}

class RecipePageState extends State<RecipePage>{

  var _name,_description,_difficult;int difficult=0;//key per i componenti grafici

  static TextEditingController recipeName,recipeDescription;//componeneti grafici
  Recipe recipe;
  Cookbook cookbook;

  RecipePageState(Recipe recipe){
    this.recipe=recipe;
    cookbook=new Cookbook();
    if(this.recipe.getDifficult()==null)this.difficult=0;
    else this.difficult=this.recipe.getDifficult();
  }

  ///
  /// Salva una nuova ricetta nel ricettario,
  /// se si sta agendo su una ricetta già presente nel ricettario questa viene modificata
  ///
  void saveRecipe() {
    if(!cookbook.containsByName(this.recipe.getName())){
      cookbook.addRecipe(this.recipe.getName());
    }
    cookbook.getRecipe(this.recipe.getName())
        .setDescription(this.recipe.getDescription())
        .setDifficult(this.recipe.getDifficult())
        .setExecutionTime(new ExecutionTime(0, 30));//TODO

    Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => CookbookPage()));

  }

  void saveState() {
    this.recipe.setName(recipeName.text)
        .setDescription(recipeDescription.text)
        .setDifficult(this.difficult);
  }


  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();//per la validazione della form

    //#region controllers

    recipeName= new TextEditingController(
      text: recipe.getName()
    );
    recipeDescription= new TextEditingController(
        text: recipe.getDescription()
    );

    //#endregion controllers

    return Scaffold(
      appBar: AppBar(
        title: Text((recipe.getName()=="")?'New Recipe':recipe.getName().toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:Form(
            key: _formKey,
            child:Column(
              children: <Widget>[
                TextFormField(
                  key: _name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 22,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2),
                  ),
                  onChanged: (value){
                    this.recipe.setName(value);
                  },
                  controller:recipeName,
                ),
                TextFormField(
                  key: _description,
                  maxLines: 10,
                  minLines: 1,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 22,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2),
                  ),
                  onChanged: (value){
                    saveState();
                  },
                  controller: recipeDescription,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.blueGrey[900],
                      onPressed:()=>{
                        setState(() {
                        if(this.difficult>0){
                          this.difficult--;
                        }
                        saveState();
                        })
                      },
                      splashColor: Colors.purple,
                      iconSize: 50,
                    ),
                    Expanded(
                      flex: 20,
                      child: Slider(
                        key: _difficult,
                        min: 0,
                        max:10,
                        label: 'Difficult : $difficult',
                        value: difficult.toDouble(),
                        divisions: 10,
                        onChanged: (double newValue) {
                          setState(() {
                            difficult = newValue.round();
                          });
                          saveState();
                        },
                        activeColor: Colors.purple,
                        inactiveColor:Colors.blueGrey[900],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.blueGrey[900],
                      onPressed:()=>{
                        setState((){
                          if(this.difficult<10){
                            this.difficult++;
                          }
                          saveState();
                        })
                      },
                      splashColor: Colors.purple,
                      iconSize: 50,
                    ),
                  ]
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Ingredients",style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
                    ),
                    new CompositeIngredientExpansion(recipe),
                    _simpleIngredients(context),//Lista ingredienti
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: ButtonTheme(
                    height: 50,
                    minWidth: 200,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          saveState();
                          saveRecipe();
                        }
                      },
                      color: Colors.blueGrey[900],
                      highlightColor: Colors.lightGreenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Save Recipe',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: this.recipe.getName()==""?false:true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.blueGrey[900],
        overlayOpacity: 0.5,
        tooltip: 'Add ingredients',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.purple,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.kitchen,color: Colors.purple),
              backgroundColor: Colors.blueGrey[900],
              label: 'Composite ingredient',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                saveState();
                saveRecipe();
                Navigator.push(
                  context,

                  MaterialPageRoute(
                  builder: (context) => CompositeIngredientPage(this.recipe.getName(),null)),
                );
              }
          ),
          SpeedDialChild(
            child: Icon(Icons.plus_one,color: Colors.purple),
            backgroundColor: Colors.blueGrey[900],
            label: 'Simple ingredient',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: (){
              saveState();
              saveRecipe();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>SimpleIngredientPage(this.recipe.getName(),null,null)),
                );
            }
          ),
        ],
      ),
    );
  }

  Widget _simpleIngredients(BuildContext context){
    List<Widget> list = new List<Widget>();
    for(Ingredient simple in this.recipe.getIngredients()){
      if(simple is SimpleIngredient){
        list.add(new ListTile(
            title: Text(simple.getName().toUpperCase(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontStyle: FontStyle.italic)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SimpleIngredientPage(this.recipe.getName(),null,simple)),
              );
              //TODO go to specific RecipePage
            },
          onLongPress: (){
            showDialog(context: context,child: _simpleDialog(context,simple.getName()));
          },
            leading: const Icon(Icons.plus_one,size: 40.0, color: Colors.blueGrey),
            subtitle: Text(simple.getAmount().toString()),
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

  Widget _simpleDialog(BuildContext context,String ingredientName) {
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

