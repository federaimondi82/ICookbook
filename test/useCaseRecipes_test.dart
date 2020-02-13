
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
    User u=new User();
    u.setName("Mario").setSurname("Rossi").setBirthday(new Birthday(10, 10, 2010));

    CookBook cookBook=new CookBook();


    cookBook.addRecipe("pizza margherita");

    cookBook.getRecipe("pizza margherita").addComposite("sugo", 100, "gr");
    cookBook.getRecipe("pizza margherita").getIngredient("sugo")
    .addByParameter("salsa di pomodoro", 1, "l")
    .addByParameter("sale", 0, "gr");

    cookBook.getRecipe("pizza margherita").addComposite("impasto per pizza", 1, "kg");
    cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza")
    .addByParameter("farina 00", 200, "gr")
    .addByParameter("sale", 10, "gr")
    .addByParameter("olio", 35, "gr")
    .addByParameter("lievito di birra", 5, "gr");

    print(cookBook.getRecipe("pizza margherita").toString());

  });

}
