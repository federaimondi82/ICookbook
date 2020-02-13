
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/domain/ingredient/compositeIngredientFactory.dart';
import 'package:ricettario/domain/ingredient/ingredient.dart';
import 'package:ricettario/domain/ingredient/simpleIngredientFactory.dart';

void main() {

  test("Inserimento Ingrediente",(){
    CompositeIngredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 500, "gr");
    ing.add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    ing.add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));

    expect(ing.contains("farina 00"),equals(true));
    expect(ing.contains("sale"),equals(true));
    expect(ing.contains("olio"),equals(true));
    expect(ing.contains("aqua"),equals(false));
    expect(ing.contains("acqua"),equals(true));
    expect(ing.contains("lievito"),equals(false));
    expect(ing.contains("lievito di birra"),equals(true));
  });

  test("Cancella Ingrediente exceptions",(){
    CompositeIngredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 500, "gr");
    Ingredient simple=SimpleIngredientFactory().createIngredient("farina 00", 200, "gr");
    ing.add(simple);
    ing.add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    ing.add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));


    expect(()=>ing.removeByName("aqua"),throwsException);
    expect(()=>ing.removeByName(""),throwsException);
    expect(()=>ing.removeByName(null),throwsException);

  });

  test("Cancella Ingrediente",(){
    CompositeIngredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 500, "gr");
    Ingredient simple=SimpleIngredientFactory().createIngredient("farina 00", 200, "gr");
    ing.add(simple);
    ing.add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    ing.add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));

    expect(ing.lenght(),equals(5));

    ing.remove(simple);
    expect(ing.lenght(),equals(4));

    ing.removeByName("sale");
    expect(ing.lenght(),equals(3));
  });

  test("Modifica Ingrediente",(){

    CompositeIngredient ing=CompositeIngredientFactory().createIngredient("impasto pizza", 500, "gr");
    ing.add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    ing.add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    ing.add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));

    Ingredient simple=ing.getIngredient("farina 00");
    expect(simple.getName(),equals("farina 00"));
    expect(simple.getAmount().getAmount(),equals(200));
    expect(simple.getAmount().getUnit().acronym,equals("gr"));


    simple.getAmount().setAmout(300);
    simple.setName("farina 0");
    expect(simple.getName(),equals("farina 0"));
    expect(simple.getAmount().getAmount(),equals(300));
    expect(simple.getAmount().getUnit().acronym,equals("gr"));

    expect(()=>ing.getIngredient("farina"),throwsException);
    expect(ing.getIngredient("farina 0"),isNotNull);

  });

  test("USE CASE inserimento ingrediente",(){

    IngredientRegister register=new IngredientRegister();
    register.addFactory("simple", new SimpleIngredientFactory());
    register.addFactory("composite", new CompositeIngredientFactory());
    
    CompositeIngredient i1=register.getFactory("composite").createIngredient("impasto per pizza", 500, "gr");

    for(int i=0;i<10;i++){
      i1.add(register.getFactory("simple").createIngredient("ingredient $i", 10 , "gr"));
    }
    expect(i1.getIngredients().length, equals(10));


  });

}
