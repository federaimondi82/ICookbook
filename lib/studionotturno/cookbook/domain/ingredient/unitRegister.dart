


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
      register.add(new Unit("pz"));
      /*register.add(new Unit("gr1"));register.add(new Unit("kg1"));
      register.add(new Unit("ml1"));register.add(new Unit("l1"));
      register.add(new Unit("gr2"));register.add(new Unit("kg2"));
      register.add(new Unit("ml2"));register.add(new Unit("l2"));
      register.add(new Unit("gr3"));register.add(new Unit("kg3"));
      register.add(new Unit("ml3"));register.add(new Unit("l3"));
      register.add(new Unit("gr4"));register.add(new Unit("kg4"));
      register.add(new Unit("ml4"));register.add(new Unit("l4"));*/
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

  bool contains(Unit unit){
    return register.contains(unit);
  }
}