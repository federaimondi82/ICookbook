

import '../lazyResource.dart';

///Questo VirtualProxy consente di conoscere i nomi delle ricette dell'utente
/// che sono state salvate in cloud.
///Consente una mappatura con le ricette in locale;
/// se queste ultime sono state cancallate in locale possono essere reperite facilmente.
abstract class RecipeMapper{

  ///ricarica le LazyResources dal backend
  void reloadProxy();

  ///Ritorna la mappatura di lezyResources tra front e backend<br>
  ///Utile per evidenzire le ricette già memorizzate in cloud dall'utente
  List<LazyResource> getMapper();

  ///ritorna il documentID del documento di una ricetta passata come parametro
  String getRecipeDocument(String recipeName);

  ///rimuove una Entry, della mappatura tra documenti e ricette, in base al nome della ricetta
  void remove(String recipeName);
}