

import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/resource.dart';

///L'astrazione ( o interfaccia ) che i contratti sulle operazioni di un Concrete Iterator;
///Secondo il pattern GOF Iterator si itera una collezione con classi al di fuori della collezione stessa
abstract class FirestoreDataIterator{

  bool hasNext();

  Resource next();

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  void reset();
}