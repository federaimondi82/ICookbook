

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unitRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/compositeIngredientPage.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/recipePage.dart';

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

  SimpleIngredient simple;
  CompositeIngredient comp;
  String recipeName;
  String newName,newUnit;double newValue;
  UnitRegister unitRegister;
  IngredientRegister register;

  final _formKey = GlobalKey<FormState>();//per la validazione della form
  TextEditingController ingredientName,ingredientQuantity;
  var _name,_quantity,_dropdownValue;

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



  @override
  Widget build(BuildContext context) {
    ingredientName= new TextEditingController(
        text: this.simple.getName()=="new simple"?"":this.simple.getName(),
    );
    ingredientQuantity= new TextEditingController(
      text: this.simple.getAmount().getAmount().toString()=="0.0"?"0":this.simple.getAmount().getAmount().toString()
    );

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
                  labelStyle: TextStyle(fontSize: 22,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2),
                ),
                controller:ingredientName,
                onChanged: (value){
                  this.newName=value;
                  this.simple.setName(this.newName);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                key: _quantity,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(fontSize: 22,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2),
                ),
                onChanged: (value){
                  this.newValue=double.parse(value);
                  this.simple.getAmount().setAmout(this.newValue);
                },
                controller:ingredientQuantity,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                //height: 200.0,
                child: Row(
                  children: <Widget>[
                    Text("Unit   ",style: TextStyle(fontSize: 22,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2),),
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
                      saveIngredient();
                    },
                    color: Colors.blueGrey[900],
                    highlightColor: Colors.lightGreenAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Save',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
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
          String ac=_dropdownValue.toString();
          this.newUnit=_dropdownValue.toString();
          this.simple.setAmount(new Quantity().setAmout(this.simple.getAmount().getAmount()).setUnit(unitRegister.getUnit(ac)));

        });
      },
      items: unitRegister.getUnits()
          .map<DropdownMenuItem<String>>((Unit value) {
        return DropdownMenuItem<String>(
          value: value.acronym,
          child: Text(value.acronym,style: TextStyle(fontSize: 26),),
        );
      }).toList(),
    );
  }

  void saveIngredient() {
    Cookbook cookbook=new Cookbook();
    this.simple.setName(this.newName);
    this.simple.setAmount(new Quantity().setAmout(this.newValue).setUnit(unitRegister.getUnit(this.newUnit)));
    if(this.comp==null){
      //salvare nella ricetta
      if(!cookbook.getRecipe(this.recipeName).containsByName(this.newName)){
        this.simple.setName(this.newName);
        this.simple.setAmount(new Quantity().setAmout(this.newValue).setUnit(unitRegister.getUnit(this.newUnit)));
        cookbook.getRecipe(this.recipeName).add(this.simple);
      }
      else{
        this.simple.setName(this.newName);
        this.simple.setAmount(new Quantity().setAmout(this.newValue).setUnit(unitRegister.getUnit(this.newUnit)));
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => RecipePage(cookbook.getRecipe(this.recipeName))));
    }
    else{
      //salvare nel composto
      if(this.comp.contains(this.simple.getName())){
        //modificare
        this.simple.setName(this.newName);
        this.simple.setAmount(new Quantity().setAmout(this.newValue).setUnit(unitRegister.getUnit(this.newUnit)));
      }else{
        //salvare nuovo
        this.comp.add(this.simple);
      }
      //this.comp.add(this.simple);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CompositeIngredientPage(this.recipeName,this.comp)));
    }

  }

}