
///
///Unità di misura da associare alle quantità per gli ingredienti.
///
class Unit{
  ///una sigla associabile ad una quantità. Esempio "gr" per grammi,"kg" per kilogrammi
  String acronym;

  Unit(this.acronym);

  String getAcronym(){
    return this.acronym;
  }
  Unit setAcronym(String acronym){
    this.acronym=acronym;
    return this;
  }

  @override
  String toString() {
    //return 'Unit{acronym: $acronym}';
    return "$acronym";
  }

  bool equals(Object obj){
    if(obj==null) return false;
    if(!(obj is Unit)) return false;
    Unit u=(obj as Unit);
    if(u.getAcronym()==this.acronym)return true;
  }

}