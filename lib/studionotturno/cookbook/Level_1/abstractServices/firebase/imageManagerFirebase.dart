
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/serviceFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/imageElement.dart';
import '../imageManager.dart';

class ImageManagerFirebase implements ImageManager{

  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://ricettario-13af3.appspot.com');
  final firestore=Firestore.instance;
  ImageElement imageElement;
  String recipeName,fileName,documentID;
  ImageManagerFirebase(){}

  ///metodo modificatore per impostare l'immagine
  ImageManagerFirebase setImage(ImageElement image){
    this.imageElement=image;
    return this;
  }

  ///metodo modificatore per impostare la ricetta relativa all'immagine
  ImageManagerFirebase setRecipeName(String recipeName) {
    this.recipeName=recipeName;
    return this;
  }


  ///consente di reperire l'immagine dal cloud storageFirebase
  Future<void> download()async{
    //TODO richiamare l'url e caricare l'immagine
  }

  ///Consente di salvare una immagine con firebase storage;
  ///url di ritorno verrà salvato insieme ai dati delle ricetta in firestore.
  ///ogni immagine è salvata con il path documentIDRecipe/nomeImmagine
  ///deve essere reperito prima il documentID e poi salvata l'immagine
  Future<void> uploadFile() async {

    Future<String> docID=ServiceFirestore().setRecipeName(this.recipeName).retrieveDocumentID();
    docID.then((value) async {
      value=this.fileName;
      final StorageReference imgRef=storage.ref().child("images/$value");
      final StorageUploadTask uploadTask = imgRef.putFile(this.imageElement.getFile());

      final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
      final String url = (await downloadUrl.ref.getDownloadURL());
      updateRecipe(url);
    });

  }

  /*///avendo precendetemente imposto il nome della ricetta viene cercato su firestore
  ///il nome del documento relatico a questa ricetta
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
      this.fileName=fileName;
      Future.value(fileName);
    }));
  }*/

  ///consente di aggiornare gli url delle immagini nel documento firestore
  ///relativo a una specifica ricetta
  void updateRecipe(String url) {
    Map<String,dynamic> map=new Map<String,dynamic>();
    List<String> list=new List<String>();

    //recupero tutte gli eventuali url delle foto dalla ricetta
    Future<DocumentSnapshot> d=firestore.collection('recipes').document(this.documentID).get();
    d.then((doc){
      Iterable l= doc.data['photos'];
      l.forEach((el)=>list.add(el.toString()));

      //invio tutti gli url delle foto (compleso quella nuova) sul database
      if(!list.contains(url))list.add(url);
      map.putIfAbsent('photos', ()=>list);
    }).whenComplete(()=> firestore.collection('recipes').document(this.documentID).updateData(map));


  }

}