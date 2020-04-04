

import 'ingredient.dart';

///Secondo il design pattern factory method, forniamo una metodologia per
///delegare l'istanziazione degli oggetti alle sottoclassi.
///La responsabilità è quella di fornire una operazione per la creazione delle istanze.
///
///E' creator di un IngredientInterface
///
/// Implementata in origine in SimpleIngedientFactory e CompositeIngredientFactory
///
abstract class IngredientFactory{

  ///
  /// Metodo creatore di una istanza che implementa IngredientInterface
  /// Necessita override
  /// name: il nome dell'ingrediente
  /// amount : un numero in virgola doppia per identificare la quantità
  /// unit : l'unità di misura per questo ingrediente (se non trovato o errato sarà in grammi (gr))
  ///
  Ingredient createIngredient(String name,double amount,String unit);
}