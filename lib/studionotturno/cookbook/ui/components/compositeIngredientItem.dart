

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/compositeIngredientPage.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/cookbookPage.dart';

///
/// Componente visuale interno al componente expander di un ingrediente composto
///
/// TODO visualizza gli ingredienti sempili al suo interno
///
///

class CompositeIngredientItem extends StatefulWidget{

  CompositeIngredient ingredient;
  String recipeName;

  CompositeIngredientItem(String recipeName,CompositeIngredient ingredient){
    this.ingredient=ingredient;
    this.recipeName=recipeName;
  }

  @override
  State<StatefulWidget> createState() =>CompositeIngredientItemState(recipeName,ingredient);


}

class CompositeIngredientItemState extends State<CompositeIngredientItem> {

  CompositeIngredient ingredient;
  String recipeName;

  CompositeIngredientItemState(String recipeName,
      CompositeIngredient ingredient) {
    this.ingredient = ingredient;
    this.recipeName = recipeName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSimpleIngredient(context),
    );
  }


  Widget showSimpleIngredient(BuildContext context) {
    List<Widget> list = new List<Widget>();

    for (SimpleIngredient simple in this.ingredient.getIngredients()) {
      String name = simple.getName();
      String subtitel = simple.getAmount().getAmount().toString() + " " +
          simple.getAmount().getUnit().getAcronym();

      TextStyle style = new TextStyle(
          fontSize: 20, fontStyle: FontStyle.italic, color: Colors.purple);
      list.add(new ListTile(
        title: Text(name, style: style),
        subtitle: Text(subtitel, style: style),
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