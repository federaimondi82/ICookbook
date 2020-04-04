


import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/unitAdapter.dart';

import 'simpleIngredientAdapter.dart';
import 'quantityAdapter.dart';
import 'target.dart';


class CompositeIngredientAdapter extends Target{

  CompositeIngredient composite;

  CompositeIngredientAdapter(){
    this.composite=new CompositeIngredient("", new Quantity());
  }

  CompositeIngredientAdapter setIngredient(CompositeIngredient composite){
    this.composite=composite;
    return this;
  }

  @override
  Map<String,dynamic > toJson() {
    return {
      "name": this.composite.name,
      "simple":false,
      "amount": this.composite.getAmount().getAmount(),
      "acronym":this.composite.amount.getUnit().getAcronym(),
      "ingredients": this.composite.composition.map((model)=>SimpleIngredientAdapter().setIngredient(model).toJson()).toList()
    };
  }

  @override
  CompositeIngredient toObject(Map<dynamic, dynamic> data) {
    this.composite.name = data['name'];
    Unit u=UnitAdapter().toObject(data['acronym']);
    this.composite.amount = new Quantity().setAmout(data['amount']).setUnit(u);
    Iterable l= data['ingredients'];//json.decode(comp['ingredients']);
    this.composite.composition = l.map((model)=>SimpleIngredientAdapter().toObject(model)).toList();
    return this.composite;
  }

}