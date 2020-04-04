

import 'package:ricettario/studionotturno/cookbook/Level_1/firestore/concreteIteratorAscendingFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/firestore/concreteIteratorByDifficultFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/firestore/concreteIteratorByIngredientFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/firestore/concreteIteratorByNameFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/firestore/concreteIteratorByTimeFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/resource.dart';

///Questa classe implementa comportamenti associabili al patter gof Iterator(concreteCollection)
/// e ad un proxy dei dati su database Firebase
///
///E' creator(patter grasp) degli iteratori (implementano iFirestoreIterator) e i
///suoi metodi restituiscono Future; i Futures sono necessari per ritornare i dati dal backend.
///Sono chiamate asincrone e necessitano di meccanismi adaguati (Future,async/await)
///
///L'utente cercando dei dati sul backend passa prima per ProxyClient che a sua volta utilizza
/// gli "iteratori" ( classi che implementano IFiresoreIterator )
class ProxyClient{

  ///permette la creazione di un iteratore per nome sulla collezione di ricette
  ///e ritorna un future dei dati filtrati sul database Firestore
  Future<Set<Resource>> getFutureByName(String name) async{
     return await new ConcreteIteratorByNameFirebase(name).get();
  }
  Set<Resource> getByName(Set<Resource> set,String name) {
    return new ConcreteIteratorByNameFirebase(name).setTheSet(set).getSet();
  }


  ///permette la creazione di un iteratore per ingredient sulla collezione di ricette
  ///e ritorna un future dei dati filtrati sul database Firestore
  Future<Set<Resource>> getFutureByIngredient(Set<Resource> set,String ingredientName) async{
    return await new ConcreteIteratorByIngredientFirebase(set, ingredientName).get();
  }
  ///permette la creazione di un iteratore per tempo di esecuzione sulla collezione di ricette
  ///e ritorna un future dei dati filtrati sul database Firestore
  Future<Set<Resource>> getFutureByTime(Set<Resource> set,int minutes) async{
    return await new ConcreteIteratorByTimeFirebase(set,minutes).get();
  }
  ///permette la creazione di un iteratore per difficoltà sulla collezione di ricette
  ///e ritorna un future dei dati filtrati sul database Firestore
  Future<Set<Resource>> createIteratorByDifficult(Set<Resource> set,int difficult) async{
    return await new ConcreteIteratorByDifficultFirebase(set,difficult).get();
  }
  ///permette la creazione di un iteratore per ritorn una collezionein ordine alfabetico
  ///e ritorna un future dei dati filtrati sul database Firestore
  Future<Set<Resource>> getFutureAscending(Set<Resource> set) async{
    return await new ConcreteIteratorAscendingFirebase(set).get();
  }

}