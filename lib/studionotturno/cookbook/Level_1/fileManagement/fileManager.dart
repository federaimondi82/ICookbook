

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';

///Permette la lettua e scrittura dei dati delle ricette in locale
///le ricette sono salvate su un file di testo
class FileManager{

  ///La struttura dati che consente di memorizzare i dati provenienti dal file
  List<Map<String,dynamic>> data;

  Cookbook cookBook=new Cookbook();

  FileManager(){
    this.data=new List<Map<String,dynamic>>();
  }

  ///calcella in modo irreversibile il file di testo dove sono memorizzte le ricette
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

  ///Consente di leggere i dati sul file di testo
  ///e costruire una struttura dati contenente le ricette
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

  ///Salva i dati di una ricetta sul file di testo in locale
  ///im parametro in input è il path
  void saveRecipe(String s) async{
    try{
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/recipes.txt');
      file.writeAsStringSync(s+"\n",flush: true,mode:FileMode.append,encoding: Encoding.getByName("UTF-8"));
    }catch(e){
      print("non si legge"+e);
    }
  }

  ///Salva tutte le ricette passate come parametro
  ///genralemente viene passato come parametro una lista generata
  ///da cookbook.getRecipes() e una codifica in json per ogni singola ricetta
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

  ///Salva dei dati per l'autenticazione dell'utente su un file di testo
  Future<bool> saveCacheFile(User user)async{
    try{
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cache.txt');
      file.delete();
      Map<String,dynamic> s1=UserAdapter().setUser(user).toJson();
      String s=JsonEncoder().convert(s1);
      await file.writeAsStringSync(s,flush: true,mode:FileMode.write,encoding: Encoding.getByName("UTF-8"));
    }catch(e){
      print("non si legge"+e);
    }
  }

  Future<List<Map<String,dynamic>>> readFileCache() async{
    try {
      List<Map<String,dynamic>> cache=new List<Map<String,dynamic>>();
      final directory = await getApplicationDocumentsDirectory();
      File('${directory.path}/cache.txt').create();
      final file = File('${directory.path}/cache.txt');

      Future<List<String>> future= file.readAsLines(encoding: Encoding.getByName("UTF-8"));
      await future.then((list)=>list.forEach((ele){
        Map<String,dynamic> s2=JsonDecoder().convert(ele);
        cache.add(s2);
      }));
      print("cache:"+cache.toString());
      return Future.value(cache);

    } catch (e) {
      print("Couldn't read file"+ e.toString());
    }
  }

  Future<bool> deleteCache()async {
    try{
      final directory = await getApplicationDocumentsDirectory();
      File('${directory.path}/cache.txt').create();
      final file = File('${directory.path}/cache.txt');
      await file.delete();
      return Future.value(true);
    }catch(e){
      print(e.toString());
      return Future.value(false);
    }
  }

}