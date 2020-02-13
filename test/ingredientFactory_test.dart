
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/domain/ingredient/compositeIngredientFactory.dart';
import 'package:ricettario/domain/ingredient/ingredient.dart';
import 'package:ricettario/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/domain/ingredient/simpleIngredientFactory.dart';

void main() {

  test("SimpleIngredient using factory exceptions",(){

    //SimpleIngredient ing_negative=SimpleIngredientFactory().createIngredient("polpa pomodoro", -1, "l");
    expect(()=>SimpleIngredientFactory().createIngredient("polpa pomodoro", -1, "l"),throwsException);

    //SimpleIngredient ing_quantityNull=SimpleIngredientFactory().createIngredient("polpa pomodoro", null, "l");
    expect(()=>SimpleIngredientFactory().createIngredient("polpa pomodoro", null, "l"),throwsException);

    //SimpleIngredient ing_wrongUnit=SimpleIngredientFactory().createIngredient("polpa pomodoro", 1, "ll");
    expect(()=>SimpleIngredientFactory().createIngredient("polpa pomodoro", 1, "ll"),throwsException);

    //SimpleIngredient ing_unitNull=SimpleIngredientFactory().createIngredient("polpa pomodoro", 1, null);
    expect(()=>SimpleIngredientFactory().createIngredient("polpa pomodoro", 1, null),throwsException);

    //SimpleIngredient ing_nameEmpty=SimpleIngredientFactory().createIngredient("", 1, "l");
    expect(()=>SimpleIngredientFactory().createIngredient("", 1, "l"),throwsException);

   // SimpleIngredient ing_nameNull=SimpleIngredientFactory().createIngredient(null, 1, "l");
    expect(()=>SimpleIngredientFactory().createIngredient(null, 1, "l"),throwsException);

  });

  test("SimpleIngredientFactory right parameter",(){

    SimpleIngredient ing=SimpleIngredientFactory().createIngredient("polpa pomodoro", 1, "l");
    expect(ing.getAmount().amount,equals(1));
    expect(ing.getAmount().unit.acronym,equals("l"));
    expect(ing.getName(),equals("polpa pomodoro"));
  });

  test("CompositeIngredient using factory exceptions",(){

    //CompositeIngredientFactory ing_negative=CompositeIngredientFactory().createIngredient("pizza", -1, "l");
    expect(()=>CompositeIngredientFactory().createIngredient("pizza", -1, "gr"),throwsException);

    //CompositeIngredientFactory ing_quantityNull=CompositeIngredientFactory().createIngredient("pizza", null, "l");
    expect(()=>CompositeIngredientFactory().createIngredient("pizza", null, "gr"),throwsException);

    //CompositeIngredientFactory ing_wrongUnit=CompositeIngredientFactory().createIngredient("pizza", 1, "ll");
    expect(()=>CompositeIngredientFactory().createIngredient("pizza", 1, "grr"),throwsException);

    //CompositeIngredientFactory ing_unitNull=CompositeIngredientFactory().createIngredient("pizza", 1, null);
    expect(()=>CompositeIngredientFactory().createIngredient("pizza", 1, null),throwsException);

    //CompositeIngredientFactory ing_nameEmpty=CompositeIngredientFactory().createIngredient("", 1, "l");
    expect(()=>CompositeIngredientFactory().createIngredient("", 1, "gr"),throwsException);

    // CompositeIngredientFactory ing_nameNull=CompositeIngredientFactory().createIngredient(null, 1, "l");
    expect(()=>CompositeIngredientFactory().createIngredient(null, 1, "gr"),throwsException);
  });

  test("CompositeIngredientFactory right parameter",(){

    Ingredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 1, "kg");
    expect(ing.getAmount().amount,equals(1));
    expect(ing.getAmount().unit.acronym,equals("kg"));
    expect(ing.getName(),equals("impasto pizza"));
  });

  test("CompositeIngredientFactory print ingredient",(){

    CompositeIngredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 500, "gr");
    ing.add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    ing.add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));
    expect(ing.getIngredients().length,equals(5));

  });


  test("CompositeIngredientFactory cast in Ingredient",(){

    Ingredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 500, "gr");
    (ing as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
    (ing as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));
    (ing as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
    (ing as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    (ing as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    expect((ing as CompositeIngredient).getIngredients().length,equals(5));

  });


}
