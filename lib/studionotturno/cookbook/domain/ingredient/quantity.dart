

import 'dart:collection';

import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unitRegister.dart';

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
  UnitRegister unitRegiter;


  Quantity(){
    unitRegiter=new UnitRegister();
  }

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
    if(!unitRegiter.contains(unit)) throw new Exception("unità di misura non presente");
    this.unit=unit;
    return this;
  }

  @override
  String toString() {
   // return toJson().toString();
   return "amount:$amount,$unit";
  }

  bool equals(Object obj){
    if(obj==null) return false;
    if(!(obj is Quantity)) return false;
    Quantity u=(obj as Quantity);
    if(u.getAmount()==this.amount
        && this.unit.equals(u.getUnit()))
      return true;
  }

  /*Map<String,dynamic> toJson(){
    return {
      "amount": this.amount,
      "unit": this.unit
    };
  }

  Quantity.fromJson(LinkedHashMap<dynamic, dynamic> json)
      : amount = json['amount'],
        unit = Unit.fromJson(json['unit']);*/

}