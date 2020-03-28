import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/mediator.dart';

void main() {

  test("Load recipes",()
  {
    Mediator mediator=new Mediator();
    mediator.loadDataFromFile();

    expect(new Cookbook().getRecipes(),isNotEmpty);
  });

  
}

/*
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
*/
