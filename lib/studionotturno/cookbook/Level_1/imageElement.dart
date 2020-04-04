
import 'dart:io';

class ImageElement{

  String ref;//il riferimento al file su cloud storage
  String documentID;//riferimento al documentID di firestore
  String recipeName;
  int count;//la posizione nell'array del documento in cloud,il riferimento al file su cloud storage
  File file;//file in locale
  String name;

  ImageElement();

  ImageElement setDocumentID(String documentID){
    this.documentID=documentID;
    return this;
  }
  ImageElement setRecipeName(String name) {
    this.recipeName=name;
    return this;
  }

  ImageElement setUri(String ref){
    this.ref=ref;
    return this;
  }
  ImageElement setFile(File file){
    this.file=file;
    return this;
  }
  ImageElement setName(String name){
    List<String> s=name.split('/');
    String s1=s.last;
    print(s1);
    this.name=s1;
    return this;
  }

  String getDocumentID(){return this.documentID;}
  String getReferiment(){return this.ref;}
  int getCount(){return this.count;}
  String getRecipeName() {return this.recipeName; }
  File getFile() {return this.file;}
  String getName(){return this.name;}

}