
///
/// La data di nascita da associare all'utente.
/// Non essendo un dato primitivo si è vista a necessità di creare una classe.
///
///
class Birthday{

  int day;
  int month;
  int year;

  Birthday(this.day,this.month,this.year);

  String toString(){
    return "${this.day}/${this.month}/${this.year}";
  }


}