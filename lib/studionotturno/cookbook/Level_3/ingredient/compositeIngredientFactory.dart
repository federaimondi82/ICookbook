




import 'compositeIngredient.dart';
import 'ingredientFactory.dart';
import 'ingredient.dart';
import 'quantity.dart';
import 'unitRegister.dart';

class CompositeIngredientFactory implements IngredientFactory{

  @override
  Ingredient createIngredient(String name, double amount, String unit) {
    UnitRegister u=new UnitRegister();
    if(name==null) throw new Exception("Nome nullo");
    else if(name.isEmpty) throw new Exception("Nome non valido");
    else if(amount==null) throw new Exception("numero quantità non valido");
    else if(amount<0) throw new Exception("numero quantità non valido");
    else if(unit==null) throw new Exception("numero quantità non valido");
    else if(u.getUnit(unit)==null) throw new Exception("unità di misura non valido");
    Quantity q=new Quantity();
    q.setAmout(amount).setUnit(u.getUnit(unit));
    return new CompositeIngredient(name,q);
  }

}