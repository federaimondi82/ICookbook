
import 'package:ricettario/domain/unit.dart';

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

}