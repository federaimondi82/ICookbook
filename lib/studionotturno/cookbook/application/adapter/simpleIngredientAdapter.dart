

import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'quantityAdapter.dart';
import 'target.dart';

///Implementa Target e è quindi la classe Adattatore di un simpleIngreginet.
///Adatta i dati tra client e server, cioè tra i dati in locale e quilli in cloud.
///E' una classe del desing pattern Adapter
///
class SimpleIngredientAdapter extends Target{

  SimpleIngredient ingredient;

  SimpleIngredientAdapter(){
    this.ingredient=new IngredientRegister().getFactory("simple").createIngredient("a", 0,"gr");
  }

  SimpleIngredientAdapter setIngredient(SimpleIngredient ingredient){
    this.ingredient=ingredient;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": this.ingredient.name,
      "amount": QuantityAdapter().setQuantity(this.ingredient.amount).toJson()
    };
  }

  @override
  SimpleIngredient toObject(Map<dynamic, dynamic> data) {
    this.ingredient.name = data['name'];
    this.ingredient.amount = QuantityAdapter().toObject(data['amount']);
    return this.ingredient;
  }

}