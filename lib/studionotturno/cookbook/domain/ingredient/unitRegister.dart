


import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unit.dart';

///
/// Singleton per memorizzare tutte le unità di misura da associare alle quantità per gli ingredienti.
///
/// Le quantità non rappresentano un dato primitivo, di conseguenza deve diventare
/// una classe e le unità di misura di una quanità ugualmente
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
      register.add(new Unit("ml"));register.add(new Unit("l"));
    }
  }

  List<Unit> getUnits(){
    return register;
  }

  Unit getUnit(String acronym){
    if(acronym==null) throw new Exception("Sigla nulla");
    else if(acronym=="") throw new Exception("Sigla vuota");
    bool trovato=false;
    register.forEach((el)=>{
      if(el.acronym==acronym) trovato=true
    });
    if(trovato==false) throw new Exception("sigla non valida");
    return register.firstWhere((el)=>el.acronym==acronym);
  }

}