

import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';

class CookbookLoader{

  Cookbook cookBook;

  CookbookLoader(){
    this.cookBook=new Cookbook();
  }

  void caricaRicette2() {
    print("caricamento ricette");
    cookBook.clear();
    cookBook.addRecipe("pizza margherita");
    cookBook.getRecipe("pizza margherita").setDifficult(3);
    cookBook.getRecipe("pizza margherita").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
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

    cookBook.getRecipe("pizza margherita").addSimple("banana", 2, "pz");


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

    //nuova ricetta3
    cookBook.addRecipe("pizza margherita1");
    cookBook.getRecipe("pizza margherita1").setDifficult(4);
    cookBook.getRecipe("pizza margherita1").setExecutionTime(new ExecutionTime(1,0));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita1").addComposite("sugo1", 100, "gr");
    CompositeIngredient c5=cookBook.getRecipe("pizza margherita1").getIngredient("sugo1");
    c5.addByParameter("salsa di pomodoro1", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita1").addComposite("impasto per pizza1", 1, "kg");
    CompositeIngredient c6=cookBook.getRecipe("pizza margherita1").getIngredient("impasto per pizza1");
    c6.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio1", 35, "gr")
        .addByParameter("lievito di birra2", 5, "gr");

    //nuova ricetta4
    cookBook.addRecipe("pizza margherita2");
    cookBook.getRecipe("pizza margherita2").setDifficult(3);
    cookBook.getRecipe("pizza margherita2").setExecutionTime(new ExecutionTime(1,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita2").addComposite("sugo2", 100, "gr");
    CompositeIngredient c7=cookBook.getRecipe("pizza margherita2").getIngredient("sugo2");
    c7.addByParameter("salsa di pomodoro2", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita2").addComposite("impasto per pizza2", 1, "kg");
    CompositeIngredient c8=cookBook.getRecipe("pizza margherita2").getIngredient("impasto per pizza2");
    c8.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio1", 35, "gr")
        .addByParameter("lievito di birra2", 5, "gr");

    //nuova ricetta5
    cookBook.addRecipe("pizza marinara1");
    cookBook.getRecipe("pizza marinara1").setDifficult(3);
    cookBook.getRecipe("pizza marinara1").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza marinara1").addComposite("sugo", 100, "gr");
    CompositeIngredient c9=cookBook.getRecipe("pizza marinara1").getIngredient("sugo");
    c9.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza marinara1").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c10=cookBook.getRecipe("pizza marinara1").getIngredient("impasto per pizza");
    c10.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio1", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    //nuova ricetta6
    cookBook.addRecipe("pizza marinara2");
    cookBook.getRecipe("pizza marinara2").setDifficult(3);
    cookBook.getRecipe("pizza marinara2").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza marinara2").addComposite("sugo", 100, "gr");
    CompositeIngredient c11=cookBook.getRecipe("pizza marinara2").getIngredient("sugo");
    c11.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza marinara2").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c12=cookBook.getRecipe("pizza marinara2").getIngredient("impasto per pizza");
    c12.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio1", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    //nuova ricetta7
    cookBook.addRecipe("pizza marinara3");
    cookBook.getRecipe("pizza marinara3").setDifficult(3);
    cookBook.getRecipe("pizza marinara3").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza marinara3").addComposite("sugo", 100, "gr");
    CompositeIngredient c13=cookBook.getRecipe("pizza marinara3").getIngredient("sugo");
    c13.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza marinara3").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c14=cookBook.getRecipe("pizza marinara3").getIngredient("impasto per pizza");
    c14.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio1", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

  }

}