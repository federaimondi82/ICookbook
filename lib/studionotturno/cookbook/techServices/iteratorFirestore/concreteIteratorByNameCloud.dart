
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/proxyFirestore/resource.dart';
import 'firestoreDataIterator.dart';

///Concrete Iterator dei dati in cloud. (Pattern GOF iterator)
///Una volta istanziato loggetto ConcreteIteratorByNameCloud viene effettuata una query nel database Firestore.
class ConcreteIteratorByNameCloud implements FirestoreDataIterator{

  Set<Resource> set;
  int currentPosition=0;
  //final firestore=Firestore.instance;

  ConcreteIteratorByNameCloud(Set<Resource> set,String name){
    Firestore.instance.collection('recipes').where("name",isEqualTo: name).getDocuments()
        .then((docs)=>docs.documents.forEach((doc) {
      String a=doc.documentID;
      String b=doc['recipeName'];
      String c=doc['executionTime'];
      LazyResource lazy=new LazyResource(a, b, c);
      this.set.add(lazy);
    }
    ));
  }

  @override
  bool hasNext() {
    return this.currentPosition<set.length;
  }

  @override
  Resource next() {
    if(hasNext()) return this.set.elementAt(this.currentPosition++);
    return null;
  }

  @override
  void reset() {
    this.currentPosition=0;
  }

}
