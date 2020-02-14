
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/domain/recipe/cookbook.dart';
import 'package:ricettario/domain/recipe/recipe.dart';
import 'package:ricettario/domain/user/birthday.dart';
import 'package:ricettario/domain/user/user.dart';

void main() {

  tearDown((){
    CookBook cookBook=new CookBook();
    cookBook.clear();
    cookBook=null;
  });

  test("cookbook exceptions",(){
    CookBook cookBook=new CookBook();

    cookBook.addRecipe("pizza margherita");
    expect(()=>cookBook.addRecipe("pizza margherita"),throwsException);
  });

  test("cookbook getRecipe exception",(){
    CookBook cookBook=new CookBook();

    cookBook.addRecipe("pizza margherita");
    expect(()=>cookBook.getRecipe("pizza margherit"),throwsException);
    expect(cookBook.getRecipe("pizza margherita"),isNotNull);

  });

  test("USE CASE inserimento ricetta",(){

    CookBook cookBook=new CookBook();
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

    expect(cookBook.getRecipes().length,equals(1));
    Recipe r=cookBook.getRecipe("pizza margherita");
    expect(cookBook.contains(r),equals(true));
    expect(cookBook.containsByName(r.getName()),equals(true));

  });

  test("USE CASE Cancella ricetta",(){

    CookBook cookBook=new CookBook();
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

    Recipe r=cookBook.getRecipe("pizza margherita");
    cookBook.remove(r);
    expect(cookBook.contains(r),equals(false));
    expect(cookBook.containsByName(r.getName()),equals(false));
    expect(cookBook.getRecipes().length,equals(0));
    expect(()=>cookBook.getRecipe(r.getName()),throwsException);
  });

  test("USE CASE modifica ricetta",(){

    CookBook cookBook=new CookBook();
    //nuova ricetta 1
    cookBook.addRecipe("pizza margherita1");
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita1").addComposite("sugo", 100, "gr");
    CompositeIngredient c1=cookBook.getRecipe("pizza margherita1").getIngredient("sugo");
    c1.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");

    expect(cookBook.getRecipes().length,equals(1));
    Recipe r1=cookBook.getRecipe("pizza margherita1");


    cookBook.getRecipe("pizza margherita1").setName("pizza margherita3");
    expect(()=>cookBook.getRecipe("pizza margherita1"),throwsException);
    expect(cookBook.getRecipe("pizza margherita3"),isNotNull);
    expect(cookBook.getRecipe("pizza margherita3").getIngredients().length,equals(1));
  });

}
