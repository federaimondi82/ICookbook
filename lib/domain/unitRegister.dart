

import 'package:ricettario/domain/unit.dart';
///
/// Singleton per memorizzare tutte le unità di misura da associare alle quantità per
/// gli ingredienti
///
///
class UnitRegister{

  static List<Unit> register;
  static final UnitRegister _register=UnitRegister._internal();

  UnitRegister._internal();

  factory UnitRegister(){
      addAllUnit();
      return _register;
  }

  static void addAllUnit(){
    if(register==null){
      register=new List<Unit>();
      register.add(new Unit("gr"));register.add(new Unit("kg"));
      register.add(new Unit("dl"));register.add(new Unit("l"));
    }
  }

  List<Unit> getUnits(){
    return register;
  }

}