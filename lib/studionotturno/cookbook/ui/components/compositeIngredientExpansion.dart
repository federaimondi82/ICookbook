

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

import 'compositeIngredientItem.dart';
import 'ingredientItem.dart';

class CompositeIngredientExpansion extends StatefulWidget{

  Recipe recipe;

  CompositeIngredientExpansion(Recipe recipe){
    this.recipe=recipe;
  }

  @override
  State<StatefulWidget> createState() => CompositeIngredientExpansionState(this.recipe);

}

class CompositeIngredientExpansionState extends State<CompositeIngredientExpansion>{

  Recipe recipe;
  List<IngredientItem> _data;

  CompositeIngredientExpansionState(Recipe recipe){
    this.recipe=recipe;
    this._data=List<IngredientItem>();
    for(Ingredient ing in recipe.getIngredients()){
      if(ing is CompositeIngredient){
        _data.add(
            new IngredientItem(
                ingredient:ing,
                type:ing is SimpleIngredient ?true:false,headerValue: ing.getName().toUpperCase(),
                expandedValue: ing.getAmount().toString().toUpperCase()
            ));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((IngredientItem item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                Text title=new Text(item.headerValue.toUpperCase(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold));
                Text subt=new Text(item.ingredient.getAmount().getAmount().round().toString()+' '+item.ingredient.getAmount().getUnit().getAcronym().toString().toLowerCase(),
                                    style:TextStyle(fontSize: 20));

                return ListTile(
                  title: title,
                  subtitle: subt,
                  trailing: Icon(Icons.kitchen,color:Colors.purple,size:40),
                );
              },
              body: item.type?
                Text(item.ingredient.getAmount().getAmount().toString()+' '+item.ingredient.getAmount().getUnit().getAcronym()+' of '+item.ingredient.getName(),
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,fontStyle: FontStyle.italic),):
                  Center(
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      child: CompositeIngredientItem(this.recipe.getName(),item.ingredient),
                    ),
                  ),
              isExpanded: item.isExpanded,
              canTapOnHeader: true,
            );
          }).toList(),
        ),
      ),
    );
  }

}
