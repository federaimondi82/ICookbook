
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/imageElement.dart';

///Gestore dei file immagine salvate in locale
class ImageManagerLocal{

  ImageElement imageElement;
  String recipeName;

  ///metodo modificatore per impostare l'immagine
  ImageManagerLocal setImage(ImageElement image){
    this.imageElement=image;
    return this;
  }

  ///metodo modificatore per impostare la ricetta relativa all'immagine
  ImageManagerLocal setRecipeName(String recipeName) {
    this.recipeName=recipeName;
    return this;
  }


  ///consente di reperire tutte le immagini in locale per una specifica ricetta
  Future<List<ImageElement>> getImages() async{
    final directory = await getApplicationDocumentsDirectory();
    String mainDir ='${directory.path}/photos';
    String recipeDir=mainDir+'/'+this.recipeName+"/";
    int count=0;
    List<ImageElement> list=new List<ImageElement>();

    Directory(recipeDir).exists().then((value){
      if(value==false)Directory(recipeDir).create(recursive: true);
    }).whenComplete((){
      Directory(recipeDir).list().length.then((value)=>count=value)
          .whenComplete((){
        if(count>0){
          Directory(recipeDir).list().forEach((el) async {
            list.add(new ImageElement().setFile(new File(el.path)).setName(el.path));
          });
        }else {}//print('3-count=0');
      });
    });
    return await Future.value(list);
  }

  ///consente di salvare in locale una immagine in locale
  ///prima di invocare questo metodo i parametri devono essere impostati
  ///sia per quanto riguarda l'immagine ( setImage ) che perla ricetta (setRecipeName )
  Future<bool> saveInLocal() async {
    try{
      //inizializzo le cartelle per le foto
      //ogni ricetta ha la propria cartella
      final directory = await getApplicationDocumentsDirectory();
      String mainDir ='${directory.path}/photos';
      String recipeDir=mainDir+'/'+this.imageElement.getRecipeName();
      DateTime now = new DateTime.now();
      String fileName=new DateTime(now.year, now.month, now.day,now.hour,now.minute,now.second).toString()+".jpg";
      await Directory(mainDir).create(recursive: true);
      await Directory(recipeDir).create();

      await this.imageElement.getFile().copy(recipeDir+"/"+fileName).then((value)=>print("newPath:"+value.path));
      await this.imageElement.getFile().delete();

      return Future.value(true);
    }catch(e){
      //print("non si legge"+e);
      return Future.value(false);
    }
  }

  ///cancellazione di una ricetta dato il path in locale
  void deleteImage(String path) async{
    File f=new File(path);
    await f.delete();
  }
}