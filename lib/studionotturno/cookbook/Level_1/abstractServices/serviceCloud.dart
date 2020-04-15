

import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';

import '../lazyResource.dart';

///Astrazione per mettere in collegamento i servizi di backend con l'applicazione;
/// serve per condividere, modificicare, reperire, cancellare ricette in cloud firestore
/// di firebase.
/// Non gestisce le immagini delle ricette in storage firebase
/// Questa astrazione consente di mantenere il SW aperto a nuove implementazioni
/// secondo il principio di Open/Close SOLID, mantiene la singola responsabilità,
/// Interface segregation è rispettata grazie all'astrazione e permette il Liskov substitution.
abstract class  ServiceCloud{

  ServiceCloud setRecipeName(String name);
  String getUrl();

  ///Invia una ricetta in cloud
  ///Se già presente, ossia una ricetta ha lo stesso nome, non può essere salvata di nuovo,
  ///ma viene modificata
  Future<bool> shareRecipe();

  ///carica tutte le ricette dal cloud dell'utente
  Future<List<Recipe>> getAllRecipeOnCloud();

  ///carica una mappatura con tutti i documenID e i nomi delle ricette dell'utente che sono memorizzare in cloud
  Future<List<LazyResource>> getAllLazyRecipeOnCloud();

  ///cancella la ricetta indicata dall'identificativo del suo documento sul backend
  Future<bool> remove(String docToRemove);

  ///dopo aver impostato il nome della ricetta è possibile reperire il suo documentID
  ///sul database in cloud; naturalmente la ricetta deve essere stata salvata
  Future<String> retrieveDocumentID();

  ///Permette di inviare delle richiesta al backend per le ricerche di ricette in base ad alcuni paramenti.<br/>
  ///E' il client del desin pattern Iterator (implementato sul backend)<br/>
  ///-List<LazyResource> list è la lista di eventuali ricette già pervenute da altre ricerche(inizialmente è vuota ovviamente)<br/>
  ///-String element è l'elemento da utulizzare nella ricerca<br/>
  ///-opt rappresenta quale delle ricerche utilizzare:<br/>
  ///--0 per nome,<br/>
  ///--1 per ingrediente,<br/>
  ///--2 per tempo di esecuzione<br/>
  ///--3 per difficoltà
  Future<List<LazyResource>> findRecipes(List<LazyResource> list,String element,int opt);

  Future<bool> sendData(Object object,String url);

}