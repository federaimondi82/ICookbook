

import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/unit.dart';

import 'target.dart';

///Implementa Target e è quindi la classe Adattatore di una Unità di misura.
///Adatta i dati tra client e server, cioè tra i dati in locale e quilli in cloud.
///E' una classe del desing pattern Adapter
class UnitAdapter extends Target{
  Unit unit;

  UnitAdapter(){
    this.unit=new Unit("a");
  }

  UnitAdapter setUnit(Unit unit){
    this.unit=unit;
    return this;
  }

  @override
  Map<String,dynamic > toJson() {
    return {
      "unit": this.unit.acronym
    };
  }

  @override
  Unit toObject(dynamic data){
    this.unit.acronym = data.toString();
    return this.unit;
  }


}