

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/serviceFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/imageElement.dart';

import '../imageManager.dart';

///Per lo storage dalle foto necessita il servizio Storage di Firebase<br>
///Dopo che le foto memorizzate su firebase gli url saranno memorizzati sul backend
///standar di springboot
class ImageManagerSpringboot  implements ImageManager{

  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://ricettario-13af3.appspot.com');
  ImageElement imageElement;
  String recipeName,fileName,documentID;

  ImageManagerSpringboot(){}

  @override
  Future<void> download() {
    // TODO: implement download
    return null;
  }

  @override
  ImageManager setImage(ImageElement image) {
    this.imageElement=image;
    return this;
  }

  @override
  ImageManager setRecipeName(String recipeName) {
    this.recipeName=recipeName;
    return this;
  }

  @override
  void updateRecipe(String url) {
    /*Map<String,dynamic> map=new Map<String,dynamic>();
    List<String> list=new List<String>();

    //recupero tutte gli eventuali url delle foto dalla ricetta
    Future<DocumentSnapshot> d=firestore.collection('recipes').document(this.documentID).get();
    d.then((doc){
      Iterable l= doc.data['photos'];
      l.forEach((el)=>list.add(el.toString()));

      //invio tutti gli url delle foto (compleso quella nuova) sul database
      if(!list.contains(url))list.add(url);
      map.putIfAbsent('photos', ()=>list);
    }).whenComplete(()=> firestore.collection('recipes').document(this.documentID).updateData(map));*/
  }

  @override
  Future<void> uploadFile() {
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

}