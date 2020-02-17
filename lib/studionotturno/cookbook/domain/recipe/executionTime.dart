
///Il tempo di esecuzione di una ricetta non è un dato primitivo, quindi è sorta
/// l'esigenza di creare una classe apposita.
class ExecutionTime {

  int _minutes;
  int _houres;

  ExecutionTime(int houres,int minutes){
    if(houres==null || minutes==null || houres>24 || houres<0 ||minutes>59||minutes<0) throw new Exception(" tempo non valido");
    this._houres=houres;
    this._minutes=minutes;
  }

  getHoures() { return this._houres;}
  getMinutes() { return this._minutes;}

  @override
  String toString() {
    //toMinutes();
    //return "$_minutes";
    return toJson().toString();
  }

  Map<String,dynamic> toJson(){
    return {
      "HH": this._houres,
      "MM": this._minutes
    };
  }

  ExecutionTime fromJson(Map<String, dynamic> json){
    _houres = json['HH'];
    _minutes= json['MM'];
    return this;
  }

  int toMinutes(){
    int m=_houres*60;
    return _minutes+=m;
  }

  bool equals(ExecutionTime t) {
    if(t==null) return false;
    if(t.getHoures()!=this.getHoures()) return false;
    if(t.getMinutes()!=this.getMinutes()) return false;
    return true;
  }


}