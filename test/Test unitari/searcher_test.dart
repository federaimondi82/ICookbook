
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

void main() {


  test("Ricerca ricetta per nome",(){

    Cookbook cookbook=new Cookbook();
    caricaRicette2();
    RecipesIterator iterator = cookbook.createIteratorByName(cookbook.getRecipes(),'pizza');

    expect(iterator,isNotNull);
    expect(iterator.hasNext(),equals(true));

   iterator.reset();
   Set<Recipe> set2=new Set<Recipe>();
    while(iterator.hasNext()){
      set2.add(iterator.next());
    }
    iterator.reset();
    expect(set2.length,greaterThan(1));
  });

  test("Ricerca ricetta per nome due volte",(){

    Cookbook cookbook=new Cookbook();
    cookbook.clear();
    caricaRicette2();
    RecipesIterator iterator = cookbook.createIteratorByName(cookbook.getRecipes(),'pizza');

    Set<Recipe> set2=new Set<Recipe>();
    while(iterator.hasNext()) set2.add(iterator.next());

    RecipesIterator iterator2=cookbook.createIteratorByName(set2, 'margherita');
    Set<Recipe> set3=new Set<Recipe>();
    while(iterator2.hasNext()) set3.add(iterator2.next());
    expect(set3.length,equals(3));

    RecipesIterator iterator3=cookbook.createIteratorByName(set3, 'marinara');
    Set<Recipe> set4=new Set<Recipe>();
    while(iterator3.hasNext()) set4.add(iterator3.next());
    expect(set4.length,equals(0));


  });


  test("Ricerca ricetta per ingrediente",(){

    Cookbook cookbook=new Cookbook();
    cookbook.clear();
    caricaRicette2();
    RecipesIterator iterator = cookbook.createIteratorByIngredient(cookbook.getRecipes(),'alici');

    expect(iterator,isNotNull);
    expect(iterator.hasNext(),equals(true));

    iterator.reset();
    Set<Recipe> set2=new Set<Recipe>();
    while(iterator.hasNext()){
      set2.add(iterator.next());
    }
    iterator.reset();
    expect(set2.length,equals(1));
  });


  test("Ricerca ricetta per nome e ingrediente",(){

    Cookbook cookbook=new Cookbook();
    cookbook.clear();
    caricaRicette2();

    //riceca ingrediente con nome pizza
    RecipesIterator iterator = cookbook.createIteratorByName(cookbook.getRecipes(),'pizza');
    Set<Recipe> set=new Set<Recipe>();
    while(iterator.hasNext()) set.add(iterator.next());
    expect(set.length,equals(6));

    //riceca ingrediente con nome pizza & margherita
    RecipesIterator iterator2 = cookbook.createIteratorByName(set,'marinara');
    Set<Recipe> set2=new Set<Recipe>();
    while(iterator2.hasNext()){
      //Recipe r=iterator2.next();
      set2.add(iterator2.next());
    }
    expect(set2.length,equals(3));

    //riceca ingrediente con nome pizza & margherita
    RecipesIterator iterator3 = cookbook.createIteratorByIngredient(set2,'alici');
    Set<Recipe> set3=new Set<Recipe>();
    while(iterator3.hasNext()){
      set3.add(iterator3.next());
    }
      expect(set3.length,equals(1));

  });

  test("Ricerca ricetta per nome,ingrediente e difficoltà",(){

    Cookbook cookbook=new Cookbook();
    caricaRicette2();
    RecipesIterator iterator = cookbook.createIteratorByName(cookbook.getRecipes(),'pizza');
    Set<Recipe> set=new Set<Recipe>();
    while(iterator.hasNext()) set.add(iterator.next());
    expect(set.length,equals(6));

    RecipesIterator iterator1 = cookbook.createIteratorByIngredient(set,'farina');
    Set<Recipe> set1=new Set<Recipe>();
    while(iterator1.hasNext()) set1.add(iterator1.next());
    expect(set1.length,equals(6));

    RecipesIterator iterator2= cookbook.createIteratorByDifficult(set1,5);
    Set<Recipe> set2=new Set<Recipe>();
    while(iterator2.hasNext()) set2.add(iterator2.next());
    expect(set2.length,equals(1));


    RecipesIterator iterator3= cookbook.createIteratorByTime(set2,35);
    Set<Recipe> set3=new Set<Recipe>();
    while(iterator3.hasNext()) set3.add(iterator3.next());
    expect(set3.length,equals(1));


  });

}

void caricaRicette() {
  Cookbook cookBook=new Cookbook();
  //nuova ricetta
  cookBook.addRecipe("pizza margherita");
  cookBook.getRecipe("pizza margherita").setDifficult(30);
  cookBook.getRecipe("pizza margherita").setExecutionTime(new ExecutionTime(3,30));
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
  cookBook.getRecipe("pizza marinara").setDifficult(30);
  cookBook.getRecipe("pizza marinara").setExecutionTime(new ExecutionTime(3,30));
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
  cookBook.addRecipe("pizza margherita 1");
  cookBook.getRecipe("pizza margherita 1").setDifficult(40);
  cookBook.getRecipe("pizza margherita 1").setExecutionTime(new ExecutionTime(3,0));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita 1").addComposite("sugo1", 100, "gr");
  CompositeIngredient c1=cookBook.getRecipe("pizza margherita 1").getIngredient("sugo1");
  c1.addByParameter("salsa di pomodoro1", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita 1").addComposite("impasto per pizza1", 1, "kg");
  CompositeIngredient c2=cookBook.getRecipe("pizza margherita 1").getIngredient("impasto per pizza1");
  c2.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra2", 5, "gr");

  //nuova ricetta4
  cookBook.addRecipe("pizza margherita 2");
  cookBook.getRecipe("pizza margherita 2").setDifficult(30);
  cookBook.getRecipe("pizza margherita 2").setExecutionTime(new ExecutionTime(3,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita 2").addComposite("sugo2", 100, "gr");
  CompositeIngredient c5=cookBook.getRecipe("pizza margherita 2").getIngredient("sugo2");
  c5.addByParameter("salsa di pomodoro2", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita 2").addComposite("impasto per pizza2", 1, "kg");
  CompositeIngredient c6=cookBook.getRecipe("pizza margherita 2").getIngredient("impasto per pizza2");
  c6.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra2", 5, "gr");

  //nuova ricetta5
  cookBook.addRecipe("pizza marinara 1");
  cookBook.getRecipe("pizza marinara 1").setDifficult(30);
  cookBook.getRecipe("pizza marinara 1").setExecutionTime(new ExecutionTime(3,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara 1").addComposite("sugo", 100, "gr");
  CompositeIngredient c7=cookBook.getRecipe("pizza marinara 1").getIngredient("sugo");
  c7.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara 1").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c8=cookBook.getRecipe("pizza marinara 1").getIngredient("impasto per pizza");
  c8.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta6
  cookBook.addRecipe("pizza marinara 2");
  cookBook.getRecipe("pizza marinara 2").setDifficult(3);
  cookBook.getRecipe("pizza marinara 2").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara 2").addComposite("sugo", 100, "gr");
  CompositeIngredient c3=cookBook.getRecipe("pizza marinara 2").getIngredient("sugo");
  c3.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara 2").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c4=cookBook.getRecipe("pizza marinara 2").getIngredient("impasto per pizza");
  c4.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio1", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //Ingredient simple=SimpleIngredientFactory().createIngredient("alici", 200, "gr");
  cookBook.getRecipe("pizza marinara 2").addSimple("alici", 200, "gr");


}