

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/unitRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/recipePage.dart';

import 'compositeIngredientPage.dart';


class SimpleIngredientPage extends StatefulWidget{

  SimpleIngredient simple;
  CompositeIngredient comp;
  String recipe;
  IngredientRegister register=new IngredientRegister();

  SimpleIngredientPage(String recipe,CompositeIngredient comp,SimpleIngredient simple){
    if(simple==null) this.simple=register.getFactory("simple").createIngredient("new simple", 0, "gr");
    else this.simple=simple;

    this.comp=comp;
    this.recipe=recipe;
  }

  IngredientRegister getRegister(){
    return this.register;
  }

  @override
  State<StatefulWidget> createState()=>  SimpleIngredientPageState(this.recipe,this.comp,this.simple);

}

class SimpleIngredientPageState extends State<SimpleIngredientPage>{

  //#region parametri di classe

  SimpleIngredient simple;
  CompositeIngredient comp;
  String recipeName;
  String newName,newUnit;double newValue;
  UnitRegister unitRegister;
  IngredientRegister register;

  TextEditingController ingredientName,ingredientQuantity;
  var _name,_quantity,_dropdownValue;

  //#endregion parametri di classe

  static TextStyle textStyle=TextStyle( fontWeight: FontWeight.bold,color: Colors.purple, fontSize: 30, fontStyle: FontStyle.italic);
  static TextStyle textFieldStyle=TextStyle(fontSize: 22,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2);

  SimpleIngredientPageState(String recipeName,CompositeIngredient comp,SimpleIngredient simple){
    this.simple=simple;
    this.comp=comp;
    this.newName=this.simple.getName();
    this.newValue=this.simple.getAmount().getAmount();
    this.newUnit=this.simple.getAmount().getUnit().getAcronym();
    this.recipeName=recipeName;
    this.unitRegister=new UnitRegister();
    this.register=new IngredientRegister();
  }

  //#region methods


  void saveState(){
    if(this.newName=="" || this.newName=="new simple"){
      showDialog(context: context, builder: (context) {
        return new AlertDialog(title: Text("Enter the name"));
      });
    }
    else{
      this.simple.setName(this.newName);
      Quantity q=new Quantity().setAmout(this.newValue).setUnit(unitRegister.getUnit(this.newUnit));
      this.simple.setAmount(q);
      saveIngredient();
    }
  }

  void saveIngredient() {
    Cookbook cookbook=new Cookbook();
    Recipe recipe=cookbook.getRecipe(this.recipeName);
    if(this.comp==null){
      //salvare l'ingrediente semplice nella ricetta
      if(!recipe.containsByName(this.newName)) recipe.add(this.simple);
      Navigator.pushReplacement( context,MaterialPageRoute(builder: (_) => RecipePage(recipe)));
    }
    else{
      //salvare l'ingrediente semplice nel composto
      if(!this.comp.contains(this.simple.getName())) this.comp.add(this.simple);
      Navigator.pushReplacement( context,MaterialPageRoute(builder: (_) => CompositeIngredientPage(this.recipeName,this.comp)));
    }

    }

  //#endregion methods

  @override
  Widget build(BuildContext context) {

    //#region controllers

    ingredientName= new TextEditingController(
        text: this.simple.getName()=="new simple"?"":this.simple.getName(),
    );
    ingredientQuantity= new TextEditingController(
      //text: this.simple.getAmount().getAmount().toString()=="0.0"?"0":this.simple.getAmount().getAmount().toString()
      text:this.simple.getAmount().getAmount().toString()
    );

    //#endregion controllers

    return Scaffold(
      appBar: AppBar(
        title: Text((this.simple.getName()=="")?'New ingredient':this.simple.getName().toUpperCase(),style:TextStyle(fontSize: 20)),
        iconTheme: IconThemeData(color: Colors.purple),
        leading: Icon(Icons.kitchen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                key: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textFieldStyle,
                ),
                controller:ingredientName,
                onChanged: (value){
                  this.newName=value;
                  this.simple.setName(this.newName);
                  //this.simple.setName(value.toString());
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                key: _quantity,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: textFieldStyle,
                ),
                onChanged: (value){
                  this.newValue=double.parse(value);
                  this.simple.getAmount().setAmout(this.newValue);
                  //this.simple.getAmount().setAmout(double.parse(value));
                },
                controller:ingredientQuantity,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                //height: 200.0,
                child: Row(
                  children: <Widget>[
                    Text("Unit   ",style: textFieldStyle,),
                    getListOfUnit(context)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: ButtonTheme(
                  height: 50,
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: (){
                      saveState();
                    },
                    color: Colors.blueGrey[900],
                    highlightColor: Colors.lightGreenAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Save Ingredient',style: textFieldStyle.copyWith(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListOfUnit(BuildContext context) {
    return DropdownButton<String>(
      hint: this.simple.getAmount().getUnit().getAcronym()!=null?Text(this.simple.getAmount().getUnit().getAcronym()):Text("Unit"),
      isDense: true,
      value: _dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 40,
      elevation: 16,
      style: TextStyle(color: Colors.blueGrey[900],fontSize: 26),
      underline: Container(
        height: 2,
        color: Colors.purple,
      ),
      onChanged: (String newValue) {
        setState(() {
          _dropdownValue = newValue;
          this.newUnit=_dropdownValue.toString();
          this.newValue=this.simple.getAmount().getAmount();
          this.newName=this.simple.getName();
          this.simple.setAmount(new Quantity().setAmout(this.simple.getAmount().getAmount()).setUnit(unitRegister.getUnit(this.newUnit)));
        });
      },
      items: unitRegister.getUnits()
          .map<DropdownMenuItem<String>>((Unit value) {
        return DropdownMenuItem<String>(
          value: value.acronym,
          child: Text(value.acronym,style: TextStyle(fontSize: 26)),
        );
      }).toList(),
    );
  }

}
