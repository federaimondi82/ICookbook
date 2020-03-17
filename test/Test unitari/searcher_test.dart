
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredientFactory.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/concreteIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';

void main() {

  tearDown((){
    Cookbook cookBook=new Cookbook();
    cookBook.clear();
    cookBook=null;

    ConcreteIterator searcher=new ConcreteIterator();
    searcher.clear();
    searcher=null;
  });

  test("Searcher searchByIngredientName",(){

    caricaRicette();

    ConcreteIterator searcher=new ConcreteIterator();
    expect(searcher.searchByIngredientName("impasto per pizza").getRecipes().length,equals(2));
    searcher.clear();
    expect(searcher.searchByIngredientName("sale").getRecipes().length,equals(2));
    searcher.clear();
  });

  test("Searcher searchByIngredient",(){

    caricaRicette();

    IngredientRegister reg1=new IngredientRegister();
    Ingredient ing1=reg1.getFactory("composite").createIngredient("impasto per pizza", 500, "gr");
    if(ing1 is CompositeIngredient){
      ing1.add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
      ing1.add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));
      ing1.add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
      ing1.add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
    }

    ConcreteIterator searcher=new ConcreteIterator();

    expect(searcher.searchByIngredient(ing1).getRecipes().length,equals(2));
    searcher.clear();

  });

  test("Searcher searchByIngredients",(){

    caricaRicette();

      SimpleIngredient s1=SimpleIngredientFactory().createIngredient("farina 00", 200, "gr");
      SimpleIngredient s2=SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr");
      SimpleIngredient s3=SimpleIngredientFactory().createIngredient("sale", 10, "gr");
      SimpleIngredient s4=SimpleIngredientFactory().createIngredient("olio", 35, "gr");
      List<Ingredient> list=new List<Ingredient>();
      list.add(s1);list.add(s2);list.add(s3);list.add(s4);


    ConcreteIterator searcher=new ConcreteIterator();

    expect(searcher.searchByIngredients(list).getRecipes().length,equals(2));
    searcher.clear();

  });

  test("Searcher searchByRecipeName",(){

    caricaRicette();

    ConcreteIterator searcher=new ConcreteIterator();

    expect(searcher.searchByRecipeName("pizza margherita").getRecipes().length,equals(1));
    expect(searcher.searchByRecipeName("pizza marinara").getRecipes().length,equals(2));
    expect(()=>searcher.searchByRecipeName("pizza fritta"),throwsException);
    expect(searcher.searchByRecipeName("pizza marinara").getRecipes().length,equals(2));
    searcher.clear();

  });

  test("Searcher searchByRecipeName",(){

    caricaRicette();

    ConcreteIterator searcher=new ConcreteIterator();

    expect(searcher.searchByExecutionTime(0,30).getRecipes(),isNotNull);
    searcher.clear();
    expect(searcher.searchByExecutionTime(1,30).getRecipes().length,equals(0));
    expect(searcher.searchByExecutionTime(0,30).getRecipes().length,equals(2));
    expect(()=>searcher.searchByExecutionTime(-1,0),throwsException);
    expect(()=>searcher.searchByExecutionTime(0,-1),throwsException);
    expect(()=>searcher.searchByExecutionTime(null,0),throwsException);
    expect(()=>searcher.searchByExecutionTime(1,null),throwsException);
    expect(()=>searcher.searchByExecutionTime(25,null),throwsException);
    expect(()=>searcher.searchByExecutionTime(1,61),throwsException);
    searcher.clear();

  });

  test("ricerca multipla1",(){

    caricaRicette2();
    ConcreteIterator searcher=new ConcreteIterator();
    IngredientRegister register=new IngredientRegister();
    expect(searcher.searchByIngredientName("sale").getRecipes().length,equals(6));
    searcher.clear();

    expect(searcher.searchByIngredientName("sale")
        .thenByIngredient(register.getFactory("simple").createIngredient("olio1", 35, "gr")).getRecipes().length,equals(4));
    searcher.clear();

    /*Set<Recipe> set1=searcher.searchByIngredientName("sale")
        .thenByIngredient(register.getFactory("simple").createIngredient("olio1", 35, "gr")).getRecipes();
    for(Recipe recipe in set1){
      print(recipe.toString());
    }*/
    searcher.clear();
    expect(searcher.searchByIngredientName("sale")
        .thenByIngredient(register.getFactory("simple").createIngredient("olio1", 35, "gr"))
        .thenByIngredient(register.getFactory("simple").createIngredient("lievito di birra2", 5, "gr"))
        .getRecipes().length,equals(2));
    /*for(Recipe recipe in set1){
      print(recipe.toString());
    }*/
    searcher.clear();

  });

  test("ricerca multipla2",(){

    caricaRicette2();
    ConcreteIterator searcher=new ConcreteIterator();
    IngredientRegister register=new IngredientRegister();
    Ingredient ing1=register.getFactory("simple").createIngredient("olio1", 35, "gr");
    Ingredient ing2=register.getFactory("simple").createIngredient("lievito di birra2", 5, "gr");
    List<Ingredient> list=new List<Ingredient>();
    list.add(ing1);
    list.add(ing2);

    expect(searcher.searchByIngredientName("sale")
        .thenByIngredient(ing1).getRecipes().length,equals(4));
    searcher.clear();

    expect(searcher.searchByIngredientName("sale")
        .thenByIngredients(list).getRecipes().length,equals(2));
    searcher.clear();

    Set<Recipe> set1=searcher.searchByIngredientName("sale").thenByIngredients(list).getRecipes();
    for(Recipe recipe in set1) print(recipe.toString());
    searcher.clear();

  });

  test("ricerca multipla3",(){

    caricaRicette2();
    ConcreteIterator searcher=new ConcreteIterator();

    expect(searcher.searchByIngredientName("sale")
        .thenByIngrendientName("olio1").getRecipes().length,equals(4));
    searcher.clear();

    expect(searcher.searchByIngredientName("sale")
        .thenByIngrendientName("olio1")
        .thenByIngrendientName("lievito di birra2").getRecipes().length,equals(2));
    searcher.clear();

    expect(searcher.searchByIngredientName("sale")
        .thenByIngrendientName("olio1")
        .thenByIngrendientName("lievito di birra2")
        .thenByDifficult(4).getRecipes().length,equals(1));
    searcher.clear();

    expect(searcher.searchByIngredientName("sale")
        .thenByIngrendientName("olio1")
        .thenByIngrendientName("lievito di birra2")
        .thenByDifficult(4).thenByExecutionTime(2, 0).getRecipes().length,equals(0));
    searcher.clear();


    /*Set<Recipe> set1=searcher.searchByIngredientName("sale")
        .thenByIngrendientName("olio1")
        .thenByIngrendientName("lievito di birra2")
        .thenByDifficult(4).getRecipes().toSet();

    for(Recipe recipe in set1) print(recipe.toString());
    searcher.clear();*/

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