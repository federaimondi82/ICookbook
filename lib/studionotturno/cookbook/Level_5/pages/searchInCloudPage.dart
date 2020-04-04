
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/concreteIteratorProxy.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/proxyClient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/resource.dart';

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
  ConcreteIteratorProxy iterator;
  ProxyClient proxyClient;
  Set<Resource> resourceFinded;

  //#endregion parametri di classe


  static TextStyle textRecipe = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic,color: Colors.black);

  SearchInCloudPageState(){
    this.resourceFinded=new Set<Resource>();
    this.proxyClient=new ProxyClient();
    this.totalTags=new Map<String,List<String>>();
    this.totalTags.putIfAbsent("name", ()=>_tagsName);
    this.totalTags.putIfAbsent("ing", ()=>_tagsIngredients);
    this.totalTags.putIfAbsent("time", ()=>_tagsExecutionTime);
  }

  //#region methods

  Future<void> refresh(Set<Resource> collection) async {
    this.iterator=new ConcreteIteratorProxy(collection);
    this.resourceFinded.clear();
    while(iterator.hasNext()) resourceFinded.add(iterator.next());
    this.iterator.reset();
    return Future.delayed(new Duration(milliseconds: 500),(){
      return Future.value();
    });
  }

  void researchAfterRemoval() {
    int i=0;
    if(_tags==0)this.resourceFinded.clear();
    else {
      Set<Resource> mySet;
      this.totalTags.entries.forEach((map) {
        if (map.key == "name" && map.value.length!=0) {
          map.value.forEach((value) async {
            if(i==0){
              this.proxyClient.getFutureByName(map.value.elementAt(0).toString())
                  .then((el)=>mySet=el).whenComplete(()=>refresh(mySet).whenComplete(()=>setState((){i++;})));
            }else{
              //this.proxyClient.getByName(this.resourceFinded,value.toString());
              mySet=this.proxyClient.getByName(this.resourceFinded,value.toString());
              await this.refresh(mySet).whenComplete(()=>setState(() {i++;}));
            }
          });
        }
/*

        if (map.key == "ing" && map.value.length!=0) {
          map.value.forEach((value) {
            i==0 ? this.iterator = cookbook.createIteratorByIngredient(this.cookbook.getRecipes(), map.value.elementAt(0).toString())
                : this.iterator = cookbook.createIteratorByIngredient(this.recipesFinded, value.toString());
            i++;
            refresh();
          });
        }

        if (map.key == "time" && map.value.length!=0) {
          map.value.forEach((value) {
            i==0 ? this.iterator = cookbook.createIteratorByTime(this.cookbook.getRecipes(), int.parse(map.value.elementAt(0).toString()))
                : this.iterator = cookbook.createIteratorByTime(this.recipesFinded, int.parse(value.toString()));
            i++;
            refresh();
          });
        }

*/

      });
      if(i==0)this.resourceFinded.clear();
    }
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
                      onRemoved: (){
                        setState(() {
                          _tagsName.removeAt(index);
                          _tags--;
                          //TODO
                          researchAfterRemoval();
                        });
                        //required
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
                      Set<Resource> mySet;
                      if(_tags==0){
                        _tagsName.add(value.toString());
                        mySet=await this.proxyClient.getFutureByName(value.toString())
                            .whenComplete((){
                          Future.delayed(new Duration(milliseconds: 500),(){
                            this.refresh(mySet).whenComplete(()=>setState(()=>_tags++));
                          });
                        });

                      }else{
                        _tagsName.add(value.toString());
                        mySet=this.proxyClient.getByName(this.resourceFinded,value.toString());
                        this.refresh(mySet).whenComplete(()=>setState(()=>_tags++));
                      }
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
                        setState(() {
                          _tagsIngredients.removeAt(index);
                          _tags--;
                          //TODO
                          //researchAfterRemoval();
                        });
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
                      await this.proxyClient.getFutureByIngredient(new Set<Resource>(),value.toString())
                          .then((el){
                        this.refresh(el).whenComplete((){
                          this.setState(() {
                              _tagsIngredients.add(value.toString());
                              _tags++;
                          });
                        });
                      });
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
                        setState(() {
                          _tagsExecutionTime.removeAt(index);
                          _tags--;
                          //TODO
                          //researchAfterRemoval();
                        });
                        //required
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
                      await this.proxyClient.getFutureByTime(new Set<Resource>(),int.parse(value))
                          .then((el){
                        this.refresh(el).whenComplete((){
                          setState(() {
                            if(_tags==0) _tagsExecutionTime.add(value);
                            else{
                              if(_tagsExecutionTime.length>0) _tagsExecutionTime.remove(value);
                              _tagsExecutionTime.add(value);
                            }
                            _tags++;

                          });
                        });
                      });
                    }
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _recipesWidget(BuildContext context){

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: this.resourceFinded.length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          LazyResource r = this.resourceFinded.toList().elementAt(index);

          return ListTile(
            title: Text(r.getRecipeName().toUpperCase(),style:textRecipe),
            onTap: () {
              /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipePage(r)),
              );*/
            },
            leading: const Icon(
                Icons.room_service, size: 20.0, color: Colors.blueGrey),
            subtitle: Text(
                r.getExecutionTime().toString() + " minutes"),
          );
        });
  }


}

