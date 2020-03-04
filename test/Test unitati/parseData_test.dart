

import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unitRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

import 'dart:convert';

void main() {


  test("parser unit to json",(){

    UnitRegister unitReg=new UnitRegister();

    Unit u=unitReg.getUnit('gr');
    String unitEncoded=json.encode(u);//codifica prima di invare al server
    var u2=json.decode(unitEncoded);//dato che ritorna dal server
    Unit uObject=Unit.fromJson(u2);
    expect(uObject, isNotNull);
   // print(uObject.toString());

  });

  test("parser quantity to json",(){

    UnitRegister unitReg=new UnitRegister();
    Quantity q=new Quantity();//una quantità di "quanto basta"
    q.setAmout(0).setUnit(unitReg.getUnits().elementAt(0));

    String quantityEncoded=json.encode(q);
    var q2=json.decode(quantityEncoded);
    Quantity qObject=Quantity.fromJson(q2);
    expect(qObject, isNotNull);
    print(qObject.toString());

  });

  test("parser time to json",(){
    ExecutionTime executionTime=new ExecutionTime(10, 10);

    String timeEncoded=json.encode(executionTime);
    var t2=json.decode(timeEncoded);
    ExecutionTime exe2=ExecutionTime.fromJson(t2);
    expect(exe2, isNotNull);
    print(exe2);

  });

  test("parser SImpleIngredient to json",(){
    UnitRegister u1=new UnitRegister();

    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple2=new SimpleIngredient("farina",q2);//100gr di farina

    String ingredientEncoded=json.encode(simple2);
    var ingredient1=json.decode(ingredientEncoded);
    SimpleIngredient ingredient2=SimpleIngredient.fromJson(ingredient1);
    print(ingredient2.toString());

  });

  test("parser CompositeIngredient to json",(){
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

    String compEncoded=json.encode(c1);
    var comp1=json.decode(compEncoded);
    CompositeIngredient ingredient2=CompositeIngredient.fromJson(comp1);
    print(ingredient2.toString());

  });

  test("parser Recipe to json",(){
    caricaRicette();
    Cookbook cookbook =new Cookbook();

    Recipe recipe=cookbook.getRecipe("pizza margherita");

    String recipeEncoded=json.encode(recipe);//da oggetto a json per il server
    var recipeVar=json.decode(recipeEncoded);//risposta dal server

    Recipe recipe2=Recipe.fromJson(recipeVar);
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

void caricaRicette2() {
  caricaRicette();
  Cookbook cookBook=new Cookbook();
  //nuova ricetta3
  cookBook.addRecipe("pizza margherita1");
  cookBook.getRecipe("pizza margherita1").setDifficult(4);
  cookBook.getRecipe("pizza margherita1").setExecutionTime(new ExecutionTime(1,0));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita1").addComposite("sugo1", 100, "gr");
  CompositeIngredient c1=cookBook.getRecipe("pizza margherita1").getIngredient("sugo1");
  c1.addByParameter("salsa di pomodoro1", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita1").addComposite("impasto per pizza1", 1, "kg");
  CompositeIngredient c2=cookBook.getRecipe("pizza margherita1").getIngredient("impasto per pizza1");
  c2.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra2", 5, "gr");

  //nuova ricetta4
  cookBook.addRecipe("pizza margherita2");
  cookBook.getRecipe("pizza margherita2").setDifficult(3);
  cookBook.getRecipe("pizza margherita2").setExecutionTime(new ExecutionTime(1,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita2").addComposite("sugo2", 100, "gr");
  CompositeIngredient c5=cookBook.getRecipe("pizza margherita2").getIngredient("sugo2");
  c5.addByParameter("salsa di pomodoro2", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita2").addComposite("impasto per pizza2", 1, "kg");
  CompositeIngredient c6=cookBook.getRecipe("pizza margherita2").getIngredient("impasto per pizza2");
  c6.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra2", 5, "gr");

  //nuova ricetta5
  cookBook.addRecipe("pizza marinara1");
  cookBook.getRecipe("pizza marinara1").setDifficult(3);
  cookBook.getRecipe("pizza marinara1").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara1").addComposite("sugo", 100, "gr");
  CompositeIngredient c7=cookBook.getRecipe("pizza marinara1").getIngredient("sugo");
  c7.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara1").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c8=cookBook.getRecipe("pizza marinara1").getIngredient("impasto per pizza");
  c8.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta6
  cookBook.addRecipe("pizza marinara2");
  cookBook.getRecipe("pizza marinara2").setDifficult(3);
  cookBook.getRecipe("pizza marinara2").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara2").addComposite("sugo", 100, "gr");
  CompositeIngredient c3=cookBook.getRecipe("pizza marinara2").getIngredient("sugo");
  c3.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara2").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c4=cookBook.getRecipe("pizza marinara2").getIngredient("impasto per pizza");
  c4.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");


}

/*test("connection to firestone",(){
      final db = Firestore.instance;

      db.collection("Federico Raimondi")
          .document("recipe1")
            .setData(
            {'name':'pizza margherita',
              'executionTime':'30',
              'difficult':'2,',
             'ingredients':
              [
                {'name':'impasto per pizza',
                'amount':'200',
                'unit':'gr',
                'ingredients':
                [
                  {'name':'farina 00',
                  'amount':'200',
                  'unit':'gr'},
                  {'name':'olio',
                  'amount':'20',
                  'unit':'gr'}
                  ]
                },
                {'name':'sugo',
                  'amount':'200',
                  'unit':'ml',
                  'ingredients':
                  [
                    {'name':'pomodoro',
                      'amount':'200',
                      'unit':'gr'},
                    {'name':'olio',
                      'amount':'20',
                      'unit':'gr'}
                  ]
                }
              ]}
              );

  });*/