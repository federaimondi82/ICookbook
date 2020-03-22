

import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unitRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/compositeIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/executionTimeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/quantityAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/recipeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/simpleIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/unitAdapter.dart';

void main() {

  test("parser unit to json",(){

    UnitRegister unitReg=new UnitRegister();
    Unit u=unitReg.getUnit('gr');//ho una istanza di una unità di misura

    expect(UnitAdapter().setUnit(u).toJson(), isNotNull);//la parso e controllo se non è nulla
    print(u.toString());  print(UnitAdapter().setUnit(u).toJson());

    //controllo inverso
    Map<String,dynamic> jsonFromCloud=UnitAdapter().setUnit(u).toJson();
    Unit u2= UnitAdapter().toObject(jsonFromCloud);
    print(u2.toString());

  });

  test("parser quantity to json",(){

    UnitRegister unitReg=new UnitRegister();
    Quantity q=new Quantity();//una quantità di "quanto basta"
    q.setAmout(0).setUnit(unitReg.getUnits().elementAt(0));

    expect(QuantityAdapter().setQuantity(q).toJson(), isNotNull);//la parso e controllo se non è nulla
    print(q.toString());  print(QuantityAdapter().setQuantity(q).toJson());

    //controllo inverso
    Map<String,dynamic> jsonFromCloud=QuantityAdapter().setQuantity(q).toJson();
    Quantity q2= QuantityAdapter().toObject(jsonFromCloud);
    print(q2.toString());
  });


  test("parser time to json",(){
    ExecutionTime executionTime=new ExecutionTime(10, 10);

    Map<String,dynamic> map=ExecutionTimeAdapter().setTime(executionTime).toJson();

    print(executionTime.toString());   print(map);

    expect(map, isNotNull);

    ExecutionTime exe2=ExecutionTimeAdapter().toObject(map);
    print(exe2.toString());

  });

  test("parser SimpleIngredient to json",(){
    UnitRegister u1=new UnitRegister();

    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple1=new SimpleIngredient("farina",q2);//100gr di farina

    Map<String,dynamic> map=SimpleIngredientAdapter().setIngredient(simple1).toJson();
    print(simple1.toString()); print(map.toString());

    SimpleIngredient simple2= SimpleIngredientAdapter().toObject(map);
    print(simple2.toString());

  });

  test("parser CompositeIngredient to json",(){
    //nuovo ingredient composto
    CompositeIngredient comp1=IngredientRegister().getFactory("composite").createIngredient("sugo", 100, "gr");
    comp1.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");


    LinkedHashMap<String,dynamic> map=CompositeIngredientAdapter().setIngredient(comp1).toJson();
    print(comp1.toString()); print(map.toString());

    CompositeIngredient comp2=CompositeIngredientAdapter().toObject(map);
    print(comp2.toString());

  });

  test("parser Recipe to json",(){
    Cookbook cookbook =new Cookbook();

    Recipe recipe=cookbook.getRecipe("pizza margherita");

    expect(recipe,isNotNull);

    Map<String,dynamic> map=RecipeAdapter().setRecipe(recipe).toJson();
    print(map.toString());

    Recipe recipe2=RecipeAdapter().toObject(map);

    print(recipe2.toString());


  });

}



void caricaRicette() {
  Cookbook cookBook=new Cookbook();
  //nuova ricetta
  cookBook.addRecipe("pizza margherita");
  cookBook.getRecipe("pizza margherita").setDifficult(3);
  cookBook.getRecipe("pizza margherita").setExecutionTime(new ExecutionTime(0,30));
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


  //nuova ricetta2
  cookBook.addRecipe("pizza marinara");
  cookBook.getRecipe("pizza marinara").setDifficult(3);
  cookBook.getRecipe("pizza marinara").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara").addComposite("sugo", 100, "gr");
  CompositeIngredient c3=cookBook.getRecipe("pizza marinara").getIngredient("sugo");
  c3.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c4=cookBook.getRecipe("pizza marinara").getIngredient("impasto per pizza");
  c4.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");
}
