
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredientFactory.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredientFactory.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';

void main() {

  tearDown((){
    Cookbook cookBook=new Cookbook();
    cookBook.clear();
  });

  test("Inserimento Ingrediente",(){
    CompositeIngredient ing=IngredientRegister().getFactory("composite").createIngredient("impasto pizza", 500, "gr");
    ing.add(IngredientRegister().getFactory("simple").createIngredient("farina 00", 200, "gr"));
    ing.add(IngredientRegister().getFactory("simple").createIngredient("sale", 10, "gr"));
    ing.add(IngredientRegister().getFactory("simple").createIngredient("olio", 35, "gr"));
    ing.add(IngredientRegister().getFactory("simple").createIngredient("acqua", 300, "ml"));
    ing.add(IngredientRegister().getFactory("simple").createIngredient("lievito di birra", 5, "gr"));

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

  test("Inserimento Ingrediente_2",(){

    IngredientRegister register=new IngredientRegister();
    /*register.addFactory("simple", new SimpleIngredientFactory());
    register.addFactory("composite", new CompositeIngredientFactory());*/
    
    CompositeIngredient i1=register.getFactory("composite").createIngredient("impasto per pizza", 500, "gr");

    for(int i=0;i<10;i++){
      i1.add(register.getFactory("simple").createIngredient("ingredient $i", 10 , "gr"));
    }
    expect(i1.getIngredients().length, equals(10));


  });

  test("USE CASE inserimento ingrediente",(){
    Cookbook cookBook=new Cookbook();

    //nuova ricetta
    cookBook.addRecipe("pizza margherita");
    expect(cookBook.getRecipe("pizza margherita"),isNotNull);

    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita").addComposite("sugo", 100, "gr");
    expect(cookBook.getRecipe("pizza margherita").getIngredient("sugo"),isNotNull);
    expect(cookBook.getRecipe("pizza margherita").getIngredients().length,equals(1));

    CompositeIngredient c1=cookBook.getRecipe("pizza margherita").getIngredient("sugo");
    c1.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    expect(cookBook.getRecipe("pizza margherita").getIngredient("sugo"),isNotNull);
    expect(cookBook.getRecipe("pizza margherita").getIngredient("sugo").getIngredient("salsa di pomodoro"),isNotNull);
    expect(()=>cookBook.getRecipe("pizza margherita").getIngredient("sugo").getIngredient("salsa pomodoro"),throwsException);

    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita").addComposite("impasto per pizza", 1, "kg");
    expect(cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza"),isNotNull);
    expect(cookBook.getRecipe("pizza margherita").getIngredients().length,equals(2));


    CompositeIngredient c2=cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza");
    c2.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");
    expect(cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza").getIngredient("farina 00"),isNotNull);

  });

  test("USE CASE modifica ingredient",(){

    Cookbook cookBook=new Cookbook();
    //nuova ricetta
    cookBook.addRecipe("pizza margherita");
    expect(cookBook.getRecipes().length,equals(1));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita").addComposite("sugo", 100, "gr");
    CompositeIngredient c1=cookBook.getRecipe("pizza margherita").getIngredient("sugo");
    c1.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita").addComposite("impasto per pizza", 1, "kg");

    expect(cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza"),isNotNull);
    CompositeIngredient c2=cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza");
    c2.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza").setName("impasto pizza");
    expect(()=>cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza"),throwsException);
    expect(cookBook.getRecipe("pizza margherita").getIngredient("impasto pizza"),isNotNull);

    cookBook.getRecipe("pizza margherita").getIngredient("impasto pizza").setAmount(new Quantity().setAmout(20));

    expect(cookBook.getRecipe("pizza margherita").getIngredient("impasto pizza").getAmount().getAmount(),equals(20));

  });

  test("USE CASE cancella ingrediente",(){
    Cookbook cookBook=new Cookbook();
    //nuova ricetta
    cookBook.addRecipe("pizza margherita");
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita").addComposite("sugo", 100, "gr");
    CompositeIngredient c1=cookBook.getRecipe("pizza margherita").getIngredient("sugo");
    c1.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c2=cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza");
    c2.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    expect(()=>cookBook.getRecipe("pizza margherita").removeByName("sale"),throwsException);

    cookBook.getRecipe("pizza margherita").removeByName("sugo");
    cookBook.getRecipe("pizza margherita").remove(c2);
    expect(cookBook.getRecipes().length,equals(1));
    expect(cookBook.getRecipe("pizza margherita").getIngredients().length,equals(0));
  });

}
