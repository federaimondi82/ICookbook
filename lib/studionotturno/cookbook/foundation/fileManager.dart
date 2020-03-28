

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';

///Permette la lettua e scrittura dei dati su un file.
class FileManager{

  ///La struttura dati che consente di memorizzare i dati provenienti dal file
  List<Map<String,dynamic>> data;

  Cookbook cookBook=new Cookbook();

  FileManager(){
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

  void saveAllRecipes(List<String> recipes) async {
    try{
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recipes.txt');
      await file.delete();
      await file.create();

      await recipes.forEach((recipe)=>saveRecipe(recipe));

    }catch(e){
      print("non si legge"+e);
    }

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

}