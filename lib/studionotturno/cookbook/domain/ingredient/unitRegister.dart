


import 'unit.dart';

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

  ///Consente di caricare le unità di misura standard da utilizzare per gli ingredienti;
  /// non è consentito usare unità di misura al di fuori di quelle precaricate.
  ///Viene chiamato alla prima chiamata della classe singleton
  static void addAllUnit(){
    if(register==null){
      register=new List<Unit>();
      register.add(new Unit("gr"));register.add(new Unit("kg"));
      register.add(new Unit("ml"));register.add(new Unit("l"));
      register.add(new Unit("pz"));
    }
  }

  List<Unit> getUnits(){
    return register;
  }

  ///In base ad una stringa rappresentante l'acronimo dell'unità di misura
  ///questo metodo restituisce una istanza da usare per gli ingredienti
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