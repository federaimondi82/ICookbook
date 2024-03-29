

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import '../../pages/compositeIngredientPage.dart';

import 'compositeIngredientItem.dart';
import 'compositeIngredientRemoveDialog.dart';
import 'ingredientItem.dart';

class CompositeIngredientExpansion extends StatefulWidget{

  Recipe recipe;
  Set<Ingredient> set;

  CompositeIngredientExpansion(Recipe recipe,Set<Ingredient> set){
    this.recipe=recipe;
    this.set=set;
  }

  @override
  State<StatefulWidget> createState() => CompositeIngredientExpansionState(this.recipe,this.set);

}

class CompositeIngredientExpansionState extends State<CompositeIngredientExpansion>{

  Recipe recipe;
  Set<Ingredient> set;
  List<IngredientItem> _data;

  CompositeIngredientExpansionState(Recipe recipe,Set<Ingredient> set){
    this.recipe=recipe;
    this.set=set;
    this._data=List<IngredientItem>();

    if(recipe==null){
      for(Ingredient ing in set){
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
    else{
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
  }

  static const TextStyle textStyle = TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.purple);

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
                  Text title=new Text(item.headerValue.toUpperCase(),style:textStyle);
                  Text subt=new Text(item.ingredient.getAmount().getAmount().round().toString()+' '+item.ingredient.getAmount().getUnit().getAcronym().toString().toLowerCase(),
                      style:textStyle);
                  return GestureDetector(
                    onLongPress: (){
                      showDialog(
                          context: context,
                          builder:(context){
                            return new CompositeIngredientRemoveDialog(context,this.recipe, item.ingredient.getName());
                      });
                    },
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => CompositeIngredientPage(this.recipe.getName(),item.ingredient))
                      );
                    },
                      child: ListTile(
                        title: title,
                        subtitle: subt,
                        trailing: Icon(Icons.kitchen,color:Colors.purple,size:40),
                      ),
                  );
                },
                body: item.type?
                Text(item.ingredient.getAmount().getAmount().toString()+' '+item.ingredient.getAmount().getUnit().getAcronym()+' of '+item.ingredient.getName(),
                  style: textStyle,):
                Center(
                  child: Container(
                    alignment: Alignment(0.0, 0.0),
                    child: new CompositeIngredientItem(item.ingredient),
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
