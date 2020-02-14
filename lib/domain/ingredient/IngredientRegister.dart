
import 'dart:collection';
import 'dart:ui';

import 'package:ricettario/domain/ingredient/compositeIngredientFactory.dart';
import 'package:ricettario/domain/ingredient/ingredient.dart';
import 'package:ricettario/domain/ingredient/ingredientFactory.dart';
import 'package:ricettario/domain/ingredient/quantity.dart';
import 'package:ricettario/domain/ingredient/simpleIngredientFactory.dart';
import 'package:ricettario/domain/ingredient/unitRegister.dart';

///Questa classe è rappresentata come Singleton  ma anche un Facade (design patterns GOF)
/// permettendo l'accesso univoco agli ingredienti; Nasconde tutte le classi del pattern
///composite e del factory method per gli ingredienti, comprese le quantità e le unità
///di misura(usate dagli ingredienti).
///Viene usato nella creazione di una ricetta quando devono essere scelti gli ingredienti.
///Di conseguenza un ingrediente per una ricetta deve essere stato precedentemente memorizzato nel IngredientRegister.
///E' un informetion exper degli IngredientFactory perchè sono questi ultimi i Creator effettivi degli ingredienti
class IngredientRegister{

  //static Map<String,SimpleIngredientFactory> simpleIngredients;
  //static Map<String,CompositeIngredientFactory> compositeIngredients;
  static HashMap<String,IngredientFactory> register;
  static final IngredientRegister _register=IngredientRegister._internal();

  IngredientRegister._internal();

  factory IngredientRegister(){
    initializeRegister();
    return _register;
  }

  static void initializeRegister(){
    if(register==null) register=new HashMap<String,IngredientFactory>();
    if(register.isEmpty) loadFactories();
  }

  void addFactory(String s, IngredientFactory simple) {
    if(s=="" || s==null) throw new Exception("Nome non valido");
    else if(simple==null) throw new Exception("Factory non valido");
    else if(register.containsKey(s) || register.containsValue(simple)) throw new Exception("Factory già presente");
    register.putIfAbsent(s, ()=>simple);
  }

  void removeFactory(String s) {
    if(s=="" || s==null) throw new Exception("Nome non valido");
    else if(!register.containsKey(s)) throw new Exception("Factory non presente");
    register.remove(s);
  }

  int size() {
    return register.length;
  }

  ///
  /// Ritorna un IngredientFactory in base al suo nome;
  /// Potrebbe trattarsi di un composto o di uno semplice o di altri ancora
  ///
  HashMap<String,IngredientFactory> getIngredientFactories() {
    return register;
  }

  IngredientFactory getFactory(String s){
    if(s=="" || s==null) throw new Exception("Nome non valido");
    else if(!register.containsKey(s)) throw new Exception("Factory non presente");
    return register.entries.firstWhere((el)=>el.key==s).value;
  }

  void clear() {
    register.clear();
  }

  static void loadFactories(){
    _register.addFactory("simple",new SimpleIngredientFactory());
    _register.addFactory("composite",new CompositeIngredientFactory());
  }

}