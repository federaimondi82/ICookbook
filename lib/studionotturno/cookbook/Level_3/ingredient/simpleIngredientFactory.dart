

import 'ingredientFactory.dart';
import 'ingredient.dart';
import 'simpleIngredient.dart';
import 'unitRegister.dart';
import 'quantity.dart';

class SimpleIngredientFactory implements IngredientFactory{

  @override
  Ingredient createIngredient(String name, double amount, String unit) {
    UnitRegister u=new UnitRegister();
    if(name==null) throw new Exception("Nome nullo");
    if(name.isEmpty) throw new Exception("Nome non valido");
    if(amount==null) throw new Exception("numero quantità non valido");
    if(amount<0) throw new Exception("numero quantità non valido");
    if(unit==null) throw new Exception("numero quantità non valido");
    if(u.getUnit(unit)==null) throw new Exception("unità di misura non valido");
    //Quantity q=new Quantity();
    //q.setAmout(amount).setUnit(u.getUnit(unit));
    return new SimpleIngredient(name,new Quantity().setAmout(amount).setUnit(u.getUnit(unit)));
    //return new SimpleIngredient(name,q);
  }

}