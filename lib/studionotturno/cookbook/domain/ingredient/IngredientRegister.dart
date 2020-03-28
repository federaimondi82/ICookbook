
import 'dart:collection';

import 'compositeIngredientFactory.dart';
import 'ingredientFactory.dart';
import 'simpleIngredientFactory.dart';

///Questa classe è rappresentata come Singleton  ma anche un Facade (design patterns GOF)
/// permettendo l'accesso univoco agli ingredienti; Nasconde tutte le classi del pattern
///composite e del factory method per gli ingredienti, comprese le quantità e le unità
///di misura(usate dagli ingredienti).
///Viene usato nella creazione di una ricetta quando devono essere scelti gli ingredienti.
///Di conseguenza un ingrediente per una ricetta deve essere stato precedentemente memorizzato nel IngredientRegister.
///E' un informetion exper degli IngredientFactory perchè sono questi ultimi i Creator effettivi degli ingredienti
class IngredientRegister{

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

  ///Consente di aggiungeredei factories al registro. Se un factory è già presente una eccezione viene sollevata;
  ///Se il nome o il factory sono nulli viene sollevata una eccezione;
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