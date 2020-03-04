

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/compositeIngredientPage.dart';

///
/// Componente visuale interno al componente expander di un ingrediente composto
///
/// TODO visualizza gli ingredienti sempili al suo interno
///
class CompositeIngredientItem extends StatelessWidget{

  CompositeIngredient ingredient;
  String recipeName;

  CompositeIngredientItem(String recipeName,CompositeIngredient ingredient){
    this.ingredient=ingredient;
    this.recipeName=recipeName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSimpleIngredient(context),
    );
  }

  Widget showSimpleIngredient(BuildContext context){
    List<Widget> list = new List<Widget>();

    for(SimpleIngredient simple in this.ingredient.getIngredients()){

      String name=simple.getName();
      String subtitel=simple.getAmount().getAmount().toString()+" "+simple.getAmount().getUnit().getAcronym();

      TextStyle style= new TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color:Colors.purple);
      list.add(new ListTile(
        title: Text(name,style: style),
        subtitle: Text(subtitel,style: style),
        onTap: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => CompositeIngredientPage(this.recipeName,this.ingredient)));
        },
      ));
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



}
/*
  CompositeIngredient ingredient;

  CompositeIngredientListView(CompositeIngredient ingredient){
    this.ingredient =ingredient;
  }

  @override
  State<StatefulWidget> createState() => CompositeIngredientListViewState(this.ingredient);

}

class CompositeIngredientListViewState extends State<CompositeIngredientListView>{

  CompositeIngredient ingredient;

  CompositeIngredientListViewState(CompositeIngredient ingredient){
    this.ingredient=ingredient;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _ingredients(context),
    );
  }

  Widget _ingredients(BuildContext context){
    List<Widget> list = new List<Widget>();
    for(Ingredient r in this.ingredient.getIngredients()){
      list.add(new ListTile(
        title: Text(r.getName().toUpperCase(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10,fontStyle: FontStyle.italic)),

        onTap: () {
          *//*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipePage(r)),
            );*//*
          //TODO go to specific RecipePage
        },
        leading: const Icon(Icons.kitchen,size: 40.0, color: Colors.blueGrey),
        subtitle: Text(r.getName().toUpperCase()+' '+r.getAmount().getAmount().round().toString()+' '+r.getAmount().getUnit().getAcronym().toLowerCase()),
        *//*subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(r.getName().toUpperCase()+' '+r.getAmount().getAmount().round().toString()+' '+r.getAmount().getUnit().getAcronym().toLowerCase()),
              ],
            ),
          ],
        ),*//*
      )
      );
    }
    return new ListView(
        children: ListTile.divideTiles(
            context: context,
            color: Colors.blueGrey,
            tiles: list
        ).toList()
    );
  }*/