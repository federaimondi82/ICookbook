

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ricettario/studionotturno/cookbook/ui/components/recipePage/compositeIngredientExpansion.dart';
import 'package:ricettario/studionotturno/cookbook/ui/components/recipePage/simpleIngredientsListView.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/compositeIngredientPage.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/cookbookPage.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/simpleIngredientPage.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/mediator.dart';


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

  //#region parametri di classe
  var _name,_description,_difficult;int difficult=0,_alert;//key per i componenti grafici
  static TextEditingController recipeName,recipeDescription;//componeneti grafici
  Recipe recipe;
  Cookbook cookbook;
  ExecutionTime time;

  //#endregion parametri di classe

  ///Costruttore
  RecipePageState(Recipe recipe){
    this.recipe=recipe;
    cookbook=new Cookbook();
    if(this.recipe.getDifficult()==null)this.difficult=0;
    else this.difficult=this.recipe.getDifficult();
    if(this.recipe.getExecutionTime()==null) this.time=new ExecutionTime(0, 0);
    else this.time=this.recipe.getExecutionTime();
  }

  //#region elementi grafici

  static const Color iconsColor=Colors.blueGrey;
  static const double iconSize=40;
  static const TextStyle labelStyle=TextStyle(fontSize: 24,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2);
  static const TextStyle textStyle=TextStyle(fontSize: 20,color: Colors.blueGrey,fontStyle: FontStyle.italic,letterSpacing: 1.2);

  //#endregion elementi grafici

  //#region metodi
  ///
  /// Salva una nuova ricetta nel ricettario,
  /// se si sta agendo su una ricetta già presente nel ricettario questa viene modificata
  ///
  void saveRecipe()async {
    try{
      saveState();
      Mediator mediator=new Mediator();
      mediator.uploadAllRecipes();
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => CookbookPage()));
    }catch(e){
      showDialog(context: context, builder: (context) {
        return new AlertDialog(title:Text("Enter the name of the recipe"));
      });

    }
  }

  void saveState() {
    this.recipe.setName(recipeName.text)
        .setDescription(recipeDescription.text)
        .setDifficult(this.difficult)
        .setExecutionTime(this.time);
    if(!cookbook.containsByName(this.recipe.getName())){
      cookbook.addRecipe(this.recipe.getName());
    }
    cookbook.getRecipe(this.recipe.getName())
        .setDescription(this.recipe.getDescription())
        .setDifficult(this.recipe.getDifficult())
        .setExecutionTime(this.time);

  }

  String addTime(double time) {
    this.time.addMinute(time);
  }
  //#endregion metodi

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
        leading: Icon(
            Icons.local_dining, size: iconSize, color: iconsColor),
        title: Text((recipe.getName()=="")?'New Recipe':recipe.getName().toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:Form(
            key: _formKey,
            child:Column(
              children: <Widget>[
                myTextField(_name,"Name",(value)=>this.recipe.setName(value),recipeName),
                myTextField(_description,"Description",(value)=>saveState(),recipeDescription),
                difficultWidgetColumn(context),
                executionTimeColumn(context),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Ingredients",style: labelStyle),
                    ),
                    new CompositeIngredientExpansion(recipe),
                    new SimpleIngredientsListView(context,recipe),//Lista ingredienti
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
                          saveRecipe();
                        }
                      },
                      color: Colors.blueGrey[900],
                      highlightColor: Colors.lightGreenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Save Recipe',style: labelStyle),
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
                //saveRecipe();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => CompositeIngredientPage(this.recipe.getName(),null)));
              }
          ),
          SpeedDialChild(
            child: Icon(Icons.plus_one,color: Colors.purple),
            backgroundColor: Colors.blueGrey[900],
            label: 'Simple ingredient',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: (){
              saveState();
              //saveRecipe();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => SimpleIngredientPage(this.recipe.getName(),null,null)));
            }
          ),
        ],
      ),
    );
  }

  Widget myTextField(Key key,String labelName,Function(String) function,TextEditingController controller){
    return TextFormField(
      key: key,
      style: textStyle,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: labelStyle,
      ),
      onChanged: function,
      controller: controller,
    );
  }

  Widget executionTimeColumn(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("Execution time",style: labelStyle),
        ),
        Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                color: iconsColor,
                onPressed:()=>{
                  setState(() {
                    if(this.time.toMinutes()<10){}
                    else addTime(-10);
                    saveState();
                  })
                },
                splashColor: Colors.purple,
                iconSize: iconSize,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    this.time.getTime(),style: textStyle.copyWith(fontSize: 50),
                  ),
                ),
                flex: 20,
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: iconsColor,
                onPressed:()=>{
                  setState((){
                    addTime(10);
                    saveState();
                  })
                },
                splashColor: Colors.purple,
                iconSize: iconSize,
              ),
            ]
        ),
      ],
    );
  }

  Widget difficultWidgetColumn(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("Difficult",style: labelStyle),
        ),
        Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                color: iconsColor,
                onPressed:()=>{
                  setState(() {
                    if(this.difficult>0){
                      this.difficult--;
                    }
                    saveState();
                  })
                },
                splashColor: Colors.purple,
                iconSize: iconSize,
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
                  inactiveColor:Colors.blueGrey,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: iconsColor,
                onPressed:()=>{
                  setState((){
                    if(this.difficult<10){
                      this.difficult++;
                    }
                    saveState();
                  })
                },
                splashColor: Colors.purple,
                iconSize: iconSize,
              ),
            ]
        ),
      ],
    );
  }

}

