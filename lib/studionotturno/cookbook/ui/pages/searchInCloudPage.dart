

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/concreteIteratorCloud.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipeIteratorCloud.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/recipePage.dart';

class SearchInCloudPage extends StatefulWidget{

  int value;
  SearchInCloudPage(this.value);

  @override
  State<StatefulWidget> createState()=>SearchInCloudPageState(this.value);

}

class SearchInCloudPageState extends State<SearchInCloudPage>{

  //#region parametri di classe

  int value;
  final List<String> _tagsName=[],_tagsIngredients=[],_tagsExecutionTime=[];
  var inputNameTags,inputIngredientTags,inputExecutionTimeTags;
  int _tags=0;//qt di tag totale
  RecipeIteratorCloud searcher;

  //#endregion parametri di classe


  static TextStyle textRecipe = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic,color: Colors.black);

  SearchInCloudPageState(this.value){
      this.searcher=new ConcreteIteratorCloud();
      this.searcher.clear();
  }

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
                        research();
                      });
                      //required
                      return true;
                    },
                  ),
                );
              },
              textField: TagsTextField(
                  lowerCase: true,
                  duplicates: false,
                  width: 600,
                  hintText: _tags>0?"then by name....":"Search by name....",
                  hintTextColor: Colors.purple,
                  textStyle: TextStyle(fontSize: 20,color: Colors.purple),
                  onSubmitted: (value){
                    setState(() {
                      if(_tags==0){
                        _tagsName.add(value.toString());
                        print("tag: "+value);
                        this.searcher.searchByRecipeName(value.toString());
                      }else{
                        _tagsName.add(value.toString());
                        this.searcher.thenByRecipeName(value.toString());
                      }
                      _tags++;
                    });
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
                        research();
                      });
                      //required
                      return true;
                    },
                  ),
                );
              },
              textField: TagsTextField(
                  lowerCase: true,
                  duplicates: false,
                  width: 600,
                  hintText: _tags>0?"then by ingredient....":"Search by ingredient....",
                  hintTextColor: Colors.purple,
                  textStyle: TextStyle(fontSize: 20,color: Colors.purple),
                  onSubmitted: (value){
                    setState(() {
                      if(_tags==0){
                        _tagsIngredients.add(value.toString());
                        this.searcher.searchByIngredientName(value.toString());
                      }else{
                        _tagsIngredients.add(value.toString());
                        this.searcher.thenByIngrendientName(value.toString());
                      }
                      _tags++;
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
                        research();
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
                  onSubmitted: (value){
                    setState(() {
                      if(_tags==0){
                        _tagsExecutionTime.add(value);
                        this.searcher.searchByExecutionTime(int.parse(value));
                      }else{
                        if(_tagsExecutionTime.length>0){
                          _tagsExecutionTime.remove(value);
                        }
                        _tagsExecutionTime.add(value);
                        this.searcher.thenByExecutionTime(int.parse(value));
                      }
                      _tags++;

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
        itemCount: this.searcher.getRecipes().length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          Recipe r = this.searcher.getRecipes().toList().elementAt(index);
          print("si aggiorna");
          return ListTile(
            title: Text(r.getName().toUpperCase(),style:textRecipe),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipePage(r)),
              );
            },
            leading: const Icon(
                Icons.room_service, size: 20.0, color: Colors.blueGrey),
            subtitle: Text(
                r.getExecutionTime().toMinutes().toString() + " minutes"),
          );
        });
  }


  ///In seguito di una cancellazione di un tag viene rifatta la ricerca in base
  ///prima del nome,poi degli ingredienti,poi della difficoltà,poi del tempo di esecuzione
  research(){
    this.searcher.clear();
    if(_tagsName.length>0) {
      this.searcher.searchByRecipeName(_tagsName.elementAt(0));
      if(_tagsName.length>1) researchByName();
    }
    if(_tagsIngredients.length>0){
      if(this.searcher.getRecipes().length>0){
        researchByIngredients();
      }else{
        this.searcher.searchByIngredientName(_tagsIngredients.elementAt(0));
        researchByIngredients();
      }
    }
    if(_tagsExecutionTime.length>0){
      if(this.searcher.getRecipes().length>0){
        researchByTime();
      }else{
        this.searcher.searchByExecutionTime(int.parse(_tagsExecutionTime.elementAt(0)));
        researchByTime();
      }
    }
  }

  void researchByName() {
    for (String el in _tagsName){
      this.searcher.thenByRecipeName(el);
    }
  }

  void researchByIngredients() {
    for(String el in _tagsIngredients){
      this.searcher.thenByIngrendientName(el);
    }
  }

  void researchByTime() {
    for(String el in _tagsExecutionTime){
      this.searcher..thenByExecutionTime(int.parse(el));
    }
  }
}

