


import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
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
      "amount": QuantityAdapter().setQuantity(this.composite.amount).toJson(),
      "ingredients": this.composite.composition.map((model)=>SimpleIngredientAdapter().setIngredient(model).toJson()).toList()
    };
  }

  @override
  CompositeIngredient toObject(Map<dynamic, dynamic> data) {
    this.composite.name = data['name'];
    this.composite.amount = QuantityAdapter().toObject(data['amount']);
    Iterable l= data['ingredients'];//json.decode(comp['ingredients']);
    this.composite.composition = l.map((model)=>SimpleIngredientAdapter().toObject(model)).toList();
    return this.composite;
  }

}