


import 'dart:collection';

import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/compositeIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/simpleIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/target.dart';

class IngredientAdapter extends Target {

  Ingredient ingredient;

  IngredientAdapter(){}

  IngredientAdapter setIngredient(Ingredient ingredient){
    this.ingredient=ingredient;
    return this;
  }


  @override
  Map<String, dynamic> toJson() {
    if(this.ingredient is SimpleIngredient){
      return SimpleIngredientAdapter().setIngredient(this.ingredient).toJson();
    }else{
      return CompositeIngredientAdapter().setIngredient(this.ingredient).toJson();
    }
  }

  @override
  Ingredient toObject(Map<dynamic, dynamic> data) {
    try{
      this.ingredient=CompositeIngredientAdapter().toObject(data);

    }catch(Exception){
      this.ingredient=SimpleIngredientAdapter().toObject(data);
    }
    return this.ingredient;
  }
}