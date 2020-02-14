

import 'package:ricettario/domain/ingredient/unit.dart';

///
/// La quantità con la quale viene misurato un ingrediente;
/// Non essendo un dato primitivo deve essere scomposto in quantità(numerica) e una
/// unità di misura.
///
/// E' stato predisposto un registro
///
class Quantity{

  double amount;
  Unit unit;


  Quantity();

  double getAmount(){
    return this.amount;
  }
  Unit getUnit(){
    return this.unit;
  }

  Quantity setAmout(double amount){
    this.amount=amount;
    return this;
  }
  Quantity setUnit(Unit unit){
    this.unit=unit;
    return this;
  }

  @override
  String toString() {
    //return 'Quantity{amount: $amount, unit: $unit}';
    return "$amount,$unit";
  }

  bool equals(Object obj){
    if(obj==null) return false;
    if(!(obj is Quantity)) return false;
    Quantity u=(obj as Quantity);
    if(u.getAmount()==this.amount
        && this.unit.equals(u.getUnit()))
      return true;
  }

}