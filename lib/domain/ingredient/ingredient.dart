
import 'package:ricettario/domain/ingredient/quantity.dart';

///
/// Gli ingredienti sono stati realizzati applicando il design pattern Composite,
/// pattern strutturare GOF.
/// Pensando che un ingrediente può essere composto da altri ingredienti è
/// sembrata la scelta migliore.
///
/// L'interfaccia IngredientInterface si implementa in SimpleIngredient o CompositeIngredient
///
///
abstract class Ingredient{

  /// Metodo modificatore per la quantità di un ingrediente
  /// amount : la quantità da usare di questo ingrediente
  ///
  void setAmount(Quantity amount){}
  ///
  /// Metodo accessore per la quantità di un ingrediente
  ///
  Quantity getAmount(){}
  ///
  /// Metodo modificatore per il nome di un ingrediente
  /// name : il nome dell'ingredient
  ///
  void setName(String name){}
  ///
  /// Metodo accessore per la quantità di un ingrediente
  ///
  String getName(){}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}