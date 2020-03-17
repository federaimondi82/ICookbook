
import 'dart:collection';

///Il tempo di esecuzione di una ricetta non è un dato primitivo, quindi è sorta
/// l'esigenza di creare una classe apposita.
class ExecutionTime {

  int minutes;
  int houres;

  ExecutionTime(int houres,int minutes){
    if(houres==null || minutes==null || houres>24 || houres<0 ||minutes>59||minutes<0) throw new Exception(" tempo non valido");
    this.houres=houres;
    this.minutes=minutes;
  }

  getHoures() { return this.houres;}
  getMinutes() { return this.minutes;}



  /*Map<String,dynamic> toJson(){
    return {
      "HH": this._houres,
      "MM": this._minutes
    };
  }

  ExecutionTime.fromJson(LinkedHashMap<dynamic, dynamic> json)
    : _houres = json['HH'],
    _minutes= json['MM'];*/


  int toMinutes(){
    int m=houres*60;
    return minutes+=m;
  }

  bool equals(ExecutionTime t) {
    if(t==null) return false;
    if(t.getHoures()!=this.getHoures()) return false;
    if(t.getMinutes()!=this.getMinutes()) return false;
    return true;
  }

  @override
  String toString() {
    return 'ExecutionTime{minutes: $minutes, houres: $houres}';
  }
}