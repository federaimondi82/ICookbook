


import 'package:ricettario/studionotturno/cookbook/techServices/iteratorFirestore/concreteIteratorByNameCloud.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/iteratorFirestore/firestoreDataIterator.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/resource.dart';

class ProxyClient{

  ProxyClient(){

  }

  ///permette la creazione di un iteratore per nome sulla collezione di ricette
  FirestoreDataIterator createIteratorByName(Set<Resource> set,String name){
    return new ConcreteIteratorByNameCloud(set,name);
  }
  ///permette la creazione di un iteratore per ingredient sulla collezione di ricette
  FirestoreDataIterator createIteratorByIngredient(Set<Resource> set,String ingredientName){

  }
  ///permette la creazione di un iteratore per tempo di esecuzione sulla collezione di ricette
  FirestoreDataIterator createIteratorByTime(Set<Resource> set,int minutes){

  }
  ///permette la creazione di un iteratore per difficoltà sulla collezione di ricette
  FirestoreDataIterator createIteratorByDifficult(Set<Resource> set,int difficult){

  }
  ///permette la creazione di un iteratore per ritorn una collezionein ordine alfabetico
  FirestoreDataIterator createIteratorAscending(Set<Resource> set){

  }

}