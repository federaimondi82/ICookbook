



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';


class SearchInCloudPage extends StatefulWidget{

  SearchInCloudPage();

  @override
  State<StatefulWidget> createState()=>SearchInCloudPageState();

}

class SearchInCloudPageState extends State<SearchInCloudPage>{

  //#region parametri di classe

  int value;

  final List<String> _tagsName=[],_tagsIngredients=[],_tagsExecutionTime=[];
  var inputNameTags,inputIngredientTags,inputExecutionTimeTags;
  Map<String,List<String>> totalTags;
  int _tags=0;//qt di tag totale
  ServiceCloud serviceCloud;
  List<LazyResource> resourceFinded;

  //#endregion parametri di classe


  static TextStyle textRecipe = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic,color: Colors.black);

  SearchInCloudPageState(){
    this.resourceFinded= new List<LazyResource>();
    this.serviceCloud=ServicesRegister().getService("springboot").createServiceCloud();
    this.totalTags=new Map<String,List<String>>();
    this.totalTags.putIfAbsent("name", ()=>_tagsName);
    this.totalTags.putIfAbsent("ing", ()=>_tagsIngredients);
    this.totalTags.putIfAbsent("time", ()=>_tagsExecutionTime);
  }

  //#region methods

  void refresh(String value, int i) async{
    List<LazyResource> list=new List<LazyResource>();//si inizia con la lista vuota
    if(_tags!=0){
      list.addAll(this.resourceFinded);
      this.resourceFinded.clear();
    }

    List<LazyResource> theList=await this.serviceCloud.findRecipes(list, value.toString(), i);
    Future.delayed(new Duration(milliseconds: 500),()async{
        if(theList!=null){
          theList.forEach((lazy)=>this.resourceFinded.add(lazy));
          //this.resourceFinded.forEach((element)=>print("2:"+element.toString()));
          setState(() {});
        }
    });

  }

  void researchAfterRemoval() async{
    Map<String,List<String>> totalTags=new Map<String,List<String>>();
    List<String> listOfName = new List<String>();
    List<String> listOfIngredient = new List<String>();
    List<String> listOfTime= new List<String>();
    totalTags.putIfAbsent("\"name\"", ()=>listOfName);
    totalTags.putIfAbsent("\"ing\"", ()=>listOfIngredient);
    totalTags.putIfAbsent("\"time\"", ()=>listOfTime);
    // ignore: missing_return
    this.totalTags.forEach((key,values){
      if(key.toString()=="name") values.forEach((el){listOfName.add("\""+el+"\"");});
      if(key.toString()=="ing") values.forEach((el)=>listOfIngredient.add("\""+el+"\""));
      if(key.toString()=="time") values.forEach((el)=>listOfTime.add("\""+el+"\""));
    });
   // this.resourceFinded.forEach((element) {print("1:"+element.toString());});

    List<LazyResource> theList=await this.serviceCloud.findRecipes( this.resourceFinded, totalTags.toString(), 4);
    Future.delayed(new Duration(milliseconds: 500),(){
      this.resourceFinded.clear();
      if(theList!=null){
        theList.forEach((lazy)=>this.resourceFinded.add(lazy));
        setState(() {});
      }//la lista viene riempita con i risultati del backend
    });
  }

  //#endregion methods

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Text("Search Recipes"),
        ),
        body:SingleChildScrollView(
          child:Column(
            children: <Widget>[
              Container(
                height: 300,
                color: Colors.white70,
                padding: EdgeInsets.all(10),
                child:_recipesWidget(context),
              ),
              Tags(
                key: inputNameTags,
                itemCount: _tagsName.length,
                itemBuilder: (int index){
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    combine: ItemTagsCombine.withTextAfter,
                    title: _tagsName.elementAt(index).toString(),
                    activeColor: Colors.blueGrey[900],
                    textActiveColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20),
                    icon: ItemTagsIcon(
                      icon: Icons.room_service,
                    ),
                    removeButton: ItemTagsRemoveButton(
                      // ignore: missing_return
                      onRemoved: (){
                        _tags--;_tagsName.removeAt(index);
                        researchAfterRemoval();
                        /*Future.delayed(new Duration(milliseconds: 300),(){
                          setState(() {
                            return true;
                          });
                        });*/
                        return true;
                      },
                    ),
                  );
                },
                textField: TagsTextField(
                    lowerCase: false,
                    duplicates: false,
                    width: 600,
                    hintText: _tags>0?"then by name....":"Search by name....",
                    hintTextColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20,color: Colors.purple),
                    onSubmitted: (value) async{
                      _tags++;_tagsName.add(value);
                      refresh(value.toString(), 0);
                    }
                ),
              ),
              Tags(
                key: inputIngredientTags,
                itemCount: _tagsIngredients.length,
                itemBuilder: (int index){
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    combine: ItemTagsCombine.withTextAfter,
                    title: _tagsIngredients.elementAt(index).toString(),
                    activeColor: Colors.blueGrey[900],
                    textActiveColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20),
                    icon: ItemTagsIcon(
                      icon: Icons.fastfood,
                    ),
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: (){
                        _tags--;_tagsIngredients.removeAt(index);
                        researchAfterRemoval();
                        return true;
                      },
                    ),
                  );
                },
                textField: TagsTextField(
                    lowerCase: false,
                    duplicates: false,
                    width: 600,
                    hintText: _tags>0?"then by ingredient....":"Search by ingredient....",
                    hintTextColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20,color: Colors.purple),
                    onSubmitted: (value) async{
                      _tagsIngredients.add(value);_tags++;
                      refresh(value.toString(),1);
                    }
                ),
              ),
              Tags(
                key: inputExecutionTimeTags,
                itemCount: _tagsExecutionTime.length,
                itemBuilder: (int index){
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    combine: ItemTagsCombine.withTextAfter,
                    title: _tagsExecutionTime.elementAt(index).toString(),
                    activeColor: Colors.blueGrey[900],
                    textActiveColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20),
                    icon: ItemTagsIcon(
                      icon: Icons.timer,
                    ),
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: (){
                        _tags--;_tagsExecutionTime.removeAt(index);
                        researchAfterRemoval();
                        return true;
                      },
                    ),
                  );
                },
                textField: TagsTextField(
                    hintText: "With time less than...",
                    duplicates: false,
                    width: 600,
                    keyboardType: TextInputType.number,
                    hintTextColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20,color: Colors.purple),
                    onSubmitted: (value) async{
                      _tagsExecutionTime.add(value);_tags++;
                      refresh(value.toString(),2);
                    }
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _recipesWidget(BuildContext context){

    /*List<LazyResource> list=[];
    this.resourceFinded.then((el)=>list.addAll(el));*/
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: resourceFinded.length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          LazyResource r = resourceFinded.elementAt(index);

          return ListTile(
            title: Text(r.getRecipeName().toUpperCase(),style:textRecipe),
            onLongPress: (){
              //TODO showdialog con tasto copia ricetta da backend a client
            },
            onTap: () {
              //todo richiamare la ricetta e visionarla sena copiarla
            },
            leading: const Icon(
                Icons.room_service, size: 20.0, color: Colors.blueGrey),
            subtitle: Text(
                r.getExecutionTime().toString() + " minutes"),
          );
        });
  }


}

