

///Il tempo di esecuzione di una ricetta non è un dato primitivo, quindi è sorta
/// l'esigenza di creare una classe apposita.
class ExecutionTime {

  double minutes, houres;

  ExecutionTime(double houres,double minutes){
    if(houres==null || minutes==null || houres>24 || houres<0 ||minutes>59||minutes<0) throw new Exception(" tempo non valido");
    this.houres=houres;
    this.minutes=minutes;
  }

  getHoures() { return this.houres;}
  getMinutes() { return this.minutes;}

  setHoures(double houres){this.houres=houres;}
  setMinutes(double minutes){this.minutes=minutes;}


  double toMinutes(){
    double m=houres*60;
    return minutes+m;
  }

  ExecutionTime addMinute(double minutes){
    double time1=toMinutes()+minutes;
    double time2=toMinutes()+minutes;

    double h=(time1/60).truncate().toDouble();
    double m=time2%60;
    setHoures(h.toDouble());
    setMinutes(m.toDouble());
    return this;
  }

  bool equals(ExecutionTime t) {
    if(t==null) return false;
    if(t.getHoures()!=this.getHoures()) return false;
    if(t.getMinutes()!=this.getMinutes()) return false;
    return true;
  }

  String getTime(){
    int h=houres.round();
    int m=minutes.round();
    return "$h : $m";
  }

  @override
  String toString() {
    return 'ExecutionTime{minutes: $minutes, houres: $houres}';
  }
}