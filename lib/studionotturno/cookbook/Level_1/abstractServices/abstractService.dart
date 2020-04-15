


import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/imageManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/authService.dart';

///Astrazione per la generazione degli oggetti del pattern.
///Secondo il desing patter Gof Abstract Factory è possibile costruire famiglie
///di oggetti correlati tra loro. Questo è stato fatto con i servivi di due diversi backend,
/// uno in springboot e l'altro con Firebase ( da migliorare entrambi ) .
///I servizi sono lo storage delle foto, dei dati delle ricette, e un mapper con risorse leggere.
///Una volta che l'utente ha decido quale servizio usare ( in fase di registrazione
/// e ognuno con differenti costi  e performance ) saranno istanziati tutti gli oggetti
/// relativi a quel servizio e utilizzati sempre.
///i dati di quale servizio usare saranno memorizzati su un file di configurazione e letti  all'avvio dell'applicazione
abstract class AbstractService{

  ///il gestore delle immagini, serve per inviare le immagini al backend storage
  ImageManager createImageManager();

  ///il mapper per le risorse leggere da usare per controllare le ricette in locale con quelle sul backend
  RecipeMapper createMapper();
  ///il servizio per la memorizzazione dei dati delle ricette e per le query sul backend
  ServiceCloud createServiceCloud();
  ///il servizio per la registrazione e login
  AuthService createServiceRegistration();

}