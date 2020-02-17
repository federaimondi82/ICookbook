

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

class Parser{

  //final db = Firestore.instance;

  static final Parser _cookBook=Parser._internal();
  Parser._internal();
  factory Parser(){
    return _cookBook;
  }

  sendRecipe(Recipe r){

    String s="";


  }

  Map<String,dynamic> parseRecipe(Recipe recipe) {

    return recipe.toJson();
  }

  Recipe parseMap(Map<String,dynamic> map) {
    return Recipe("").fromJson(map);
  }
}