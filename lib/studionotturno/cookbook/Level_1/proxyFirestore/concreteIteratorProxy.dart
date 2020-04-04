
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/resource.dart';

///ConcreteCollection del patter Iterator. Questa classe itera i dati perventi
/// dal database dopo delle ricerce;
///itera i dati da ProxyClient (svolge compiti di proxy per mostrare dati più
/// leggeri di quelli backend e mostra la collezione dei dati pervenuti dal backend)
class ConcreteIteratorProxy{

  Set<Resource> set;
  int currentPosition=0;

  ConcreteIteratorProxy(this.set);

  bool hasNext() {
    return this.currentPosition<set.length;
  }

  Resource next() {
    if(hasNext()) return this.set.elementAt(this.currentPosition++);
    return null;
  }

  void reset(){
    this.currentPosition=0;
  }

}