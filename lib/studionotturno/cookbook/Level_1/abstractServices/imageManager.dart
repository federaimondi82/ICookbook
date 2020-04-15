

import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/imageElement.dart';

///
/// Permette di inviare,reperire,cancellare le immagini delle ricette sul cloud
///
abstract class ImageManager{

  ///metodo modificatore per impostare l'immagine
  ImageManager setImage(ImageElement image);

  ///metodo modificatore per impostare la ricetta relativa all'immagine
  ImageManager setRecipeName(String recipeName);


  ///consente di reperire l'immagine dal cloud
  Future<void> download();

  ///Consente di salvare una immagine in cloud
  ///url di ritorno verrà salvato insieme ai dati delle ricetta sullo stesso cloud
  ///Le immagini non sono salvate sul database, ma su uno storage separato per
  ///mantenere un database di soli dati
  Future<void> uploadFile();

  ///consente di aggiornare gli url delle immagini nel documento firestore
  ///relativo a una specifica ricetta
  void updateRecipe(String url);

}