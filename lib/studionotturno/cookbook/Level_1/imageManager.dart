
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/imageElement.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';

///Implementa Target e è quindi la classe Adattatore di una Unità di misura.
///Adatta i dati tra client e server, cioè tra i dati in locale e quilli in cloud.
///E' una classe del desing pattern Adapter
class ImageManager {

  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://ricettario-13af3.appspot.com');
  final firestore=Firestore.instance;
  ImageElement imageElement;
  String recipeName,fileName,documentID;
  ImageManager(){}

  ImageManager setImage(ImageElement image){
    this.imageElement=image;
    return this;
  }

  ImageManager setRecipeName(String recipeName) {
    this.recipeName=recipeName;
    return this;
  }


  Future<void> download()async{

  }

  ///Concente di salvare una immagine con firebase storage
  ///url di ritorno verrà salvato insieme ai dati delle ricetta in firestore
  Future<void> uploadFile() async {

    /*final directory = await getApplicationSupportDirectory ();
    //scrive un file
    final File file = await File('${directory.path}/foo.txt').create();
    await file.writeAsString('hello');
    //lo salva
    assert(await file.readAsString() == 'hello');*/

    Future<String> docID=getDocumentID();
    docID.then((value) async {
      value=this.fileName;
      final StorageReference imgRef=storage.ref().child("images/$value");
      final StorageUploadTask uploadTask = imgRef.putFile(this.imageElement.getFile());

      final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
      final String url = (await downloadUrl.ref.getDownloadURL());
      //print('URL Is $url');
      updateRecipe(url);
    });

  }

  ///avendo precendetemente imposto il nome della ricetta viene cercato su firestore
  ///il nome del documento relatico a qiesta ricetta
  Future<String> getDocumentID(){
    if(this.recipeName==null) throw new Exception("nome ricetta non presente");
    User u=new User();
    if(u.getEmail()==null) throw new Exception("utente non autenticato");
    String fileName;

    return firestore.collection('recipes').where('userName',isEqualTo: u.getEmail())
        .where('recipeName',isEqualTo: this.recipeName).limit(1)
        .getDocuments().then((docs){
      docs.documents.forEach((doc)=>this.documentID=doc.documentID);
    }).whenComplete((){
      fileName=this.documentID+"/"+this.imageElement.getName();
    }).whenComplete(()=>Future.delayed(new Duration(milliseconds: 50),(){
      print(fileName);
      this.fileName=fileName;
      Future.value(fileName);
    }));
  }

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
        }else print('3-count=0');
      });
    });
    return await Future.value(list);
  }

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
      print("non si legge"+e);
        return Future.value(false);
    }
  }

  void deleteImage(String path) async{
    File f=new File(path);
    await f.delete();
  }

  void updateRecipe(String url) {
    Map<String,dynamic> map=new Map<String,dynamic>();
    List<String> list=new List<String>();

    //recupero tutte gli eventuali url delle foto dalla ricetta
    Future<DocumentSnapshot> d=firestore.collection('recipes').document(this.documentID).get();
    d.then((doc){
      Iterable l= doc.data['photos'];
      l.forEach((el)=>list.add(el.toString()));

      if(!list.contains(url))list.add(url);
      map.putIfAbsent('photos', ()=>list);
    }).whenComplete(()=> firestore.collection('recipes').document(this.documentID).updateData(map));


  }

}