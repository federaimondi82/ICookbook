

import '../lazyResource.dart';

///Questo VirtualProxy consente di conoscere i nomi delle ricette dell'utente
/// che sono state salvate in cloud.
///Consente una mappatura con le ricette in locale;
/// se queste ultime sono state cancallate in locale possono essere reperite facilmente.
abstract class RecipeMapper{

  void reloadProxy();

  List<LazyResource> getMapper();

  String getRecipeDocument(String recipeName);

  ///rimuove una Entry, della mappatura tra documenti e ricette, in base al nome della ricetta
  void remove(String recipeName);
}