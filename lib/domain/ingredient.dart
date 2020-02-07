
import 'package:ricettario/domain/quantity.dart';

///
/// Una classe per definire un ingrediente in una ricetta
/// Ogni ingrediente è formato da una materia prima con una quantità ( a cui è assocuata
/// una unità di misura);
///
///
///
class Ingredient{

  String name;
  Quantity amount;

  Ingredient setName(String name){
    this.name=name;
    return this;
  }

  Ingredient setAmount(Quantity amount){
    this.amount=amount;
    return this;
  }


}