
///Il tempo di esecuzione di una ricetta non è un dato primitivo, quindi è sorta
/// l'esigenza di creare una classe apposita.
class Timer {

  int _minutes;
  int _houres;

  Timer(){ }

  int get minutes => _minutes;
  int get houres => _houres;

  set minutes(int value) {
    _minutes = value;
  }
  set houres(int value) {
    _houres = value;
  }

  @override
  String toString() {
    return '{$_houres:$_minutes}';
  }
}