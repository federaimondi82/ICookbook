
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

///Interfaccia per definire i metodi di accesso alla collezione;
///Definisce anche metodi di attreversamento non convenzionali ma specifici per la collezione
abstract class RecipesIterator{

  bool hasNext();

  Recipe next();

  ///Elimina dalla lista tutte le ricette fino ad ora ottenute dalle ricerche
  void reset();

}