


import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/ingredient.dart';

///Classe per gli elementi grafici dell'expanded
class IngredientItem{

  Ingredient ingredient;
  String expandedValue;
  String headerValue;
  bool isExpanded;
  bool type;//se l'ingrediente è semplice o composito

  IngredientItem({this.ingredient,this.expandedValue,this.headerValue,
    this.isExpanded=false, this.type,});
}