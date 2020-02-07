
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
    return 'Unit{acronym: $acronym}';
  }

}