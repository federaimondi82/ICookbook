


import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'compositeIngredientAdapter.dart';
import 'simpleIngredientAdapter.dart';
import 'target.dart';

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

    if(data['simple']==true){
      this.ingredient=SimpleIngredientAdapter().toObject(data);
    }
    else{
      this.ingredient=CompositeIngredientAdapter().toObject(data);
    }
    return this.ingredient;
  }
}