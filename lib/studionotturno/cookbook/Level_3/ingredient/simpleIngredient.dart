


import 'ingredient.dart';
import 'quantity.dart';

///un ingrediente semplice, non composto da altri ingredienti
///Implementa l'interfaccia comune, IngredientInterface, sia per gli ingredienti semplici
///che per quelli composti (CompositeIngredient)
///
///Fa parte dei design pattern Gof Composite e Factory method;
///Composite perchè un ingrediente può essere usato singolarmente ma anche con altri ingredienti.
///Factory Method perchè viene delegata una classe specifica (SimpleIngredientFactory) per la
/// creazione di una istanza; questo per disaccoppiare le responsabilità;
/// le dipendenze aumentano, ma si traduce in una alta coesione maggiore(pattern grasp)
class SimpleIngredient implements Ingredient{

  Quantity amount;
  String name;

  ///Construttore
  ///name : il nome dell'ingredient
  /// amount : la quantità da usare di questo ingrediente
  SimpleIngredient(this.name,this.amount);

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

  @override
  String toString() {
    return "name:$name,$amount";
  }

  bool equals(Object obj) {
    if(obj==null) return false;
    if(!(obj is SimpleIngredient))return false;
    SimpleIngredient simple=(obj as SimpleIngredient);
    if(simple.getName()==null) return false;
    if(simple.getAmount()==null) return false;
    if(simple.getAmount().getAmount()==this.amount.getAmount() &&
      simple.getAmount().getUnit().getAcronym()==this.amount.getUnit().getAcronym() && simple.getName()==this.name)
    //if(simple.getAmount().equals(this.amount) && simple.getName()==this.name)
      return true;
  }

}