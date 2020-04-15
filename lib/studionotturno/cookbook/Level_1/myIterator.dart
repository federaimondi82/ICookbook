


import 'package:ricettario/studionotturno/cookbook/Level_1/resource.dart';

///L'astrazione ( o interfaccia ) che i contratti sulle operazioni di un Concrete Iterator;
///Secondo il pattern GOF Iterator si itera una collezione con classi al di fuori della collezione stessa
///Questo è Iterator particolare, mostra solo un metodo get() che restituisce un future;
///Le comptaioni di ricerc sul cloud sono asincrone e le specifiche ricerche sono implementate nei concreteIterator
abstract class MyIterator{

  /*bool hasNext();

  Resource next();

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  void reset();*/

  ///QUesto metodo si comporta come un metodo accssore
  ///Restituisce il future della computazione asincrona con all'interno i valori
  ///delle Resource trovate; Reasource è l'astrazione padre per Recipe e LazyResource
  ///da usare secondo le necesità
  Future<Set<Resource>> get();
}