

import 'ingredient.dart';
import 'quantity.dart';
import 'simpleIngredient.dart';
import 'simpleIngredientFactory.dart';

///un ingrediente composto da altri ingredienti semplici (SimpleIngredient),
///Implementa l'interfaccia comune, IngredientInterface, sia per gli ingredienti semplici
///che per quelli composti (CompositeIngredient)
///
///Fa parte dei design pattern Gof Composite e Factory method;
///Composite perchè un ingrediente può essere usato singolarmente ma anche con altri ingredienti.
///Factory Method perchè viene delegata una classe specifica (CompositeIngredientFactory) per la
///creazione di una istanza; questo per disaccoppiare le responsabilità;
/// le dipendenze aumentano, ma si traduce in una alta coesione maggiore(pattern grasp)
class CompositeIngredient implements Ingredient{


  Quantity amount;
  String name;
  List<Ingredient> composition;

  CompositeIngredient(this.name,this.amount){
    this.composition=new List<Ingredient>();
  }

  @override
  Quantity getAmount() {
    return this.amount;
  }

  @override
  String getName() {
    return this.name;
  }

  @override
  void setAmount(Quantity amount) {
    this.amount=amount;
  }

  @override
  void setName(String name) {
    this.name=name;
  }

  ///
  /// Metodo accessore per la lista degli ingredienti di questo composto
  ///
  List<Ingredient> getIngredients(){
    return this.composition;
  }

  ///
  /// Aggiunge in ingrediente a questo composto
  /// Ritorna false se l'ingrediente è già contenuto o se è nullo, altriemnti true;
  ///
  CompositeIngredient add(Ingredient ingredient){
    if(this.composition.contains(ingredient)) throw new Exception("Ingrediente presente");
    else if(ingredient==null) throw new Exception("Ingrediente presente");
    this.composition.add(ingredient);
    return this;
  }

  CompositeIngredient addByParameter(String name,double amount,String unit){
    add(SimpleIngredientFactory().createIngredient(name, amount, unit));
    return this;
  }

  ///
  ///Agginge una serie di ingredienti a questo composto
  ///Ritorna false se la lista è nulla o vuota o un suo membro è nullo,altrimenti true;
  ///
  bool addAll(List<Ingredient> list){
    if(list==null) return false;
    else if(list.contains(null)) return false;
    else if(list.length==0) return false;
    else if(list.any((el)=>this.composition.contains(el))) return false;
    list.forEach((el)=>this.composition.add(el));
    return true;
  }

  ///
  /// Rimuove in ingrediente a questo composto
  /// Ritorna false se l'ingrediente è nullo oppure se non è già contenuto,altrimenti true;
  ///
  bool remove(Ingredient ingredient){
    if(ingredient==null) return false;//throw new Exception("Ingrediente nullo");
    else if(!this.composition.contains(ingredient)) return false;//throw new Exception("Ingrediente non presente");
    this.composition.remove(ingredient);
    return true;
  }

  bool removeByName(String name){
    if(name==null) throw new Exception("nome nullo");
    else if(name.isEmpty) throw new Exception("nome vuoto");
    else if(contains(name)==false) throw new Exception("ingrediente non presente");
    return this.composition.remove(getIngredient(name));
  }

  ///
  /// Rimuove una serie di ingredienti da questo composto.
  /// Ritorna false se la lista è nulla o vuota o gli ingredienti di questa lista
  /// non sono presenti, altrimenti true;
  ///
  bool removeAll(List<Ingredient> list){
    if(list==null) return false;
    else if(list.contains(null)) return false;
    else if(list.length==0) return false;
    else if(list.every((el)=>!this.composition.contains(el))) return false;
    list.forEach((el)=>this.composition.remove(el));
    return true;
  }

  ///Consente di sapere se un ingrediente è stato inserito in questo composto
  ///name : il nome dell'ingrediente (deve essere esatto: es. 'farina' è divero da 'farina 00' e anche da 'Farina')
  ///
  bool contains(String name){
    bool trovato=false;
    for (Ingredient el in this.composition) {
      if (el.getName() == name) trovato = true;
    }
    return trovato;
  }

  ///Ritorna l'ingrediente identificato con un certo nome
  ///name : il nome dell'ingrediente (deve essere esatto: es. 'farina' è divero da 'farina 00' e anche da 'Farina')
  ///
  Ingredient getIngredient(String name){
    if(name==null) throw new Exception("nome nullo");
    else if(name.isEmpty) throw new Exception("nome vuoto");
    else if(!contains(name)) throw new Exception("ingrediente non presente");
    return this.composition.where((el)=>el.getName()==name).elementAt(0);
  }

  int lenght() {
    return this.composition.length;
  }

  @override
  String toString() {
    //return toJson().toString();
    //return '{"name":"$name","$amount","ingredient":"$composition"}';
    return "name:$name,$amount,ingredients:$composition";
  }

  bool equals(Object obj) {
    if(obj==null) return false;
    if(!(obj is CompositeIngredient))return false;
    CompositeIngredient comp=(obj as CompositeIngredient);
    if(this.getName()!=comp.getName()) return false;
    if(comp.getIngredients().length!=composition.length) return false;
    bool trovato =true;
    for(Ingredient i in comp.getIngredients()){
      Ingredient here=getIngredient(i.getName());
      if(i is SimpleIngredient){
        if(!(i as SimpleIngredient).equals(here))trovato=false;
      }
      else if(i is CompositeIngredient){
        if(!(i as CompositeIngredient).equals(here)) trovato=false;
      }
    }
    return trovato;
  }
}