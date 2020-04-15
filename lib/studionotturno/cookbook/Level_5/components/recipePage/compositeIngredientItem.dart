

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';

///
/// Componente visuale interno al componente expander di un ingrediente composto
/// Visualizza gli ingredienti semplici al suo interno
///
///

class CompositeIngredientItem extends StatefulWidget{

  CompositeIngredient ingredient;

  CompositeIngredientItem(CompositeIngredient ingredient){
    this.ingredient=ingredient;
  }

  @override
  State<StatefulWidget> createState() =>CompositeIngredientItemState(ingredient);


}

class CompositeIngredientItemState extends State<CompositeIngredientItem> {

  CompositeIngredient ingredient;

  CompositeIngredientItemState(
      CompositeIngredient ingredient) {
    this.ingredient = ingredient;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSimpleIngredient(context),
    );
  }
  static const TextStyle textStyle = TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.blueGrey);

  Widget showSimpleIngredient(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (SimpleIngredient simple in this.ingredient.getIngredients()) {
      String name = simple.getName();
      String subtitel = simple.getAmount().getAmount().toString() + " " +
          simple.getAmount().getUnit().getAcronym();

      list.add(new ListTile(
        title: Text(name+"  "+subtitel, style: textStyle),
        //subtitle: Text(subtitel, style: textStyle),
      ));
    }
    return new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: ListTile.divideTiles(
            context: context,
            color: Colors.purple,
            tiles: list
        ).toList()
    );
  }

}