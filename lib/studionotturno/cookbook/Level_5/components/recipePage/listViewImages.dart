


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/ImageMagagerLocal.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/imageElement.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/imageManagerFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/recipePage.dart';

///Componente per mostrare le immagini di una ricetta nella pagona della stessa
class ListViewImages extends StatefulWidget{

  String recipeName;
  BuildContext context;
  ListViewImages(this.context,this.recipeName);

  @override
  State<StatefulWidget> createState()=>ListViewImagesState(this.context,this.recipeName);
}
class ListViewImagesState extends State<ListViewImages>{

  String recipeName;
  ImageManagerLocal imageManager;
  Future<List<ImageElement>> fut;
  BuildContext context;
  Cookbook cookbook;

  @override
  void initState(){
    this.fut=this.imageManager.getImages();
  }

  ///nel costruttore avvio la ricerca delle immagini con un future e costruisce
  ///una lista di widget per costruire poi la griglia
  ListViewImagesState(this.context,this.recipeName) {
    this.imageManager = new ImageManagerLocal().setRecipeName(this.recipeName);
    this.cookbook=new Cookbook();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<ImageElement>> (
      future: this.fut,
      builder:(context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if(snapshot.connectionState==ConnectionState.done){
          return new GridView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemBuilder: (context,index){
                return new FlatButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        child: new SimpleDialog(
                          titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          children: <Widget>[
                            Padding(//share
                              padding: EdgeInsets.all(0),
                              child: Image.file(snapshot.data.elementAt(index).getFile()),
                            ),
                          ],
                        ));
                  },
                    onLongPress: ()async{
                      setState(() {
                        showDialog(
                            context: context,
                            child: new SimpleDialog(
                              titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              children: <Widget>[
                                Text("TODO",style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
                                Padding(//delete
                                  padding: EdgeInsets.all(20),
                                  child: RaisedButton(
                                    onPressed:() async {
                                      await this.imageManager.deleteImage(snapshot.data.elementAt(index).getFile().path);
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>RecipePage(this.cookbook.getRecipe(this.recipeName))));
                                    },
                                    color: Colors.blueGrey[900],
                                    highlightColor: Colors.lightGreenAccent,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(' DELETE Image ',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
                                  ),
                                ),
                                Padding(//share
                                  padding: EdgeInsets.all(20),
                                  child: RaisedButton(
                                    onPressed:() async {
                                      //TODO salva immagine in cloud
                                      ImageManagerFirebase().setRecipeName(this.recipeName)
                                          .setImage(snapshot.data.elementAt(index))
                                      .uploadFile();


                                    },
                                    color: Colors.blueGrey[900],
                                    highlightColor: Colors.lightGreenAccent,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(' SHARE Image ',style: TextStyle(fontSize: 20,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2)),
                                  ),
                                ),
                              ],
                            ));
                      });
                    },
                    child: Image.file(snapshot.data.elementAt(index).getFile(),width: 100,));
              });
        }
        return null;
      },
    );

  }

}