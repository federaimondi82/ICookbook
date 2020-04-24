

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/recipeAdapter.dart';


class MokeStarter{

  ///La struttura dati che consente di memorizzare i dati provenienti dal file
  List<Map<String,dynamic>> data;

  Cookbook cookBook=new Cookbook();

  MokeStarter(){
    // this.cookBook=new Cookbook();
    this.data=new List<Map<String,dynamic>>();
  }

  void deleteFile()async {
    try{
      final directory = await getApplicationDocumentsDirectory();
      File('${directory.path}/recipes.txt').create();
      final file = File('${directory.path}/recipes.txt');

      file.delete();
    }catch(e){
      print(e);
    }

  }

  ///Consente di leggere i dati sul file e costruire una struttura dati contenente le ricette
  Future<List<Map<String,dynamic>>> readDataIntoFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      File('${directory.path}/recipes.txt').create();
      final file = File('${directory.path}/recipes.txt');

      //file.delete();
      Future<List<String>> future= file.readAsLines();
      await future.then((list)=>list.forEach((ele){
        Map<String,dynamic> s2=JsonDecoder().convert(ele);
        this.data.add(s2);
      }));
      return Future.value(this.data);

    } catch (e) {
      print("Couldn't read file"+ e.toString());
    }
  }

  ///Salva i dati di una ricetta sul file di storage
  void saveRecipe(String s) async{
    try{
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recipes.txt');
      file.writeAsStringSync(s+"\n",flush: true,mode:FileMode.append,encoding: Encoding.getByName("UTF-8"));
    }catch(e){
      print("non si legge"+e);
    }
  }

  void saveAllRecipes() async {
    try{
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recipes.txt');
      await file.delete();
      await file.create();

      List<String> recipes=new List<String>();
      this.cookBook.getRecipes().forEach((recipe){
        Map<String,dynamic> s1=RecipeAdapter().setRecipe(recipe).toJson();
        recipes.add(JsonEncoder().convert(s1));
      });
      recipes.forEach((recipe)=>saveRecipe(recipe));

    }catch(e){
      print(e);
    }

  }

  void caricaRicette2() {
    //print("caricamento ricette");
    //Cookbook cookBook=new Cookbook();
    cookBook.clear();

    cookBook.addRecipe("spaghetti allo scoglio");
    cookBook.getRecipe("spaghetti allo scoglio").setDifficult(1);
    cookBook.getRecipe("spaghetti allo scoglio").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
    cookBook.getRecipe("spaghetti allo scoglio").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("spaghetti allo scoglio").addComposite("sugo", 100, "gr");
    CompositeIngredient d7=cookBook.getRecipe("spaghetti allo scoglio").getIngredient("sugo");
    d7.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("spaghetti allo scoglio").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient d8=cookBook.getRecipe("spaghetti allo scoglio").getIngredient("impasto per pizza");
    d8.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    cookBook.getRecipe("spaghetti allo scoglio").addSimple("banana", 2, "pz");


    cookBook.addRecipe("trota");
    cookBook.getRecipe("trota").setDifficult(3);
    cookBook.getRecipe("trota").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
    cookBook.getRecipe("trota").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("trota").addComposite("sugo", 100, "gr");
    CompositeIngredient d5=cookBook.getRecipe("trota").getIngredient("sugo");
    d5.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("trota").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient d6=cookBook.getRecipe("trota").getIngredient("impasto per pizza");
    d6.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    cookBook.getRecipe("trota").addSimple("banana", 2, "pz");


    cookBook.addRecipe("torciglioni alla carbonara");
    cookBook.getRecipe("torciglioni alla carbonara").setDifficult(3);
    cookBook.getRecipe("torciglioni alla carbonara").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
    cookBook.getRecipe("torciglioni alla carbonara").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("torciglioni alla carbonara").addComposite("sugo", 100, "gr");
    CompositeIngredient d3=cookBook.getRecipe("torciglioni alla carbonara").getIngredient("sugo");
    d3.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("torciglioni alla carbonara").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient d4=cookBook.getRecipe("torciglioni alla carbonara").getIngredient("impasto per pizza");
    d4.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    cookBook.getRecipe("torciglioni alla carbonara").addSimple("banana", 2, "pz");


    cookBook.addRecipe("spaghetti alla carbonara");
    cookBook.getRecipe("spaghetti alla carbonara").setDifficult(3);
    cookBook.getRecipe("spaghetti alla carbonara").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
    cookBook.getRecipe("spaghetti alla carbonara").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("spaghetti alla carbonara").addComposite("sugo", 100, "gr");
    CompositeIngredient d1=cookBook.getRecipe("spaghetti alla carbonara").getIngredient("sugo");
    d1.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("spaghetti alla carbonara").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient d2=cookBook.getRecipe("spaghetti alla carbonara").getIngredient("impasto per pizza");
    d2.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    cookBook.getRecipe("spaghetti alla carbonara").addSimple("banana", 2, "pz");

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
    cookBook.getRecipe("pizza margherita1").addComposite("sugo", 100, "gr");
    CompositeIngredient c5=cookBook.getRecipe("pizza margherita1").getIngredient("sugo");
    c5.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita1").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c6=cookBook.getRecipe("pizza margherita1").getIngredient("impasto per pizza");
    c6.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    //nuova ricetta4
    cookBook.addRecipe("pizza margherita2");
    cookBook.getRecipe("pizza margherita2").setDifficult(3);
    cookBook.getRecipe("pizza margherita2").setExecutionTime(new ExecutionTime(1,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza margherita2").addComposite("sugo", 100, "gr");
    CompositeIngredient c7=cookBook.getRecipe("pizza margherita2").getIngredient("sugo");
    c7.addByParameter("salsa di pomodoro2", 1, "l")
        .addByParameter("sale", 0, "gr");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza margherita2").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c8=cookBook.getRecipe("pizza margherita2").getIngredient("impasto per pizza");
    c8.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

    //nuova ricetta5
    cookBook.addRecipe("pizza marinara1");
    cookBook.getRecipe("pizza marinara1").setDifficult(3);
    cookBook.getRecipe("pizza marinara1").setExecutionTime(new ExecutionTime(0,30));
    //aggiunta di una ingrediente composto
    cookBook.getRecipe("pizza marinara1").addComposite("sugo", 100, "gr");
    CompositeIngredient c9=cookBook.getRecipe("pizza marinara1").getIngredient("sugo");
    c9.addByParameter("salsa di pomodoro", 1, "l")
        .addByParameter("sale", 0, "gr")
        .addByParameter("alici", 20, "pz");
    //aggiunta di un secondo ingrediente composto
    cookBook.getRecipe("pizza marinara1").addComposite("impasto per pizza", 1, "kg");
    CompositeIngredient c10=cookBook.getRecipe("pizza marinara1").getIngredient("impasto per pizza");
    c10.addByParameter("farina 00", 200, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
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
        .addByParameter("olio", 35, "gr")
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
        .addByParameter("olio", 35, "gr")
        .addByParameter("lievito di birra", 5, "gr");

  }

  void loadCookbook() async{
    List<Recipe> recipes=new List<Recipe>();
    await this.readDataIntoFile().then((ele)=>ele.forEach((ele){
      recipes.add(RecipeAdapter().toObject(ele));
    }));
    recipes.toSet().forEach((recipe)=>cookBook.addRecipeObject(recipe));
  }




}