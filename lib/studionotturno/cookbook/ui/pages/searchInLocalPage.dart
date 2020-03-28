

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:ricettario/studionotturno/cookbook/application/Iterator/recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/recipePage.dart';

class SearchInLocalPage extends StatefulWidget{

  int value;
  SearchInLocalPage(this.value);

  @override
  State<StatefulWidget> createState()=>SearchInLocalPageState(this.value);

}

class SearchInLocalPageState extends State<SearchInLocalPage>{

  //#region parametri di classe

  int value;
  final List<String> _tagsName=[],_tagsIngredients=[],_tagsExecutionTime=[];
  Map<String,List<String>> totalTags;
  var inputNameTags,inputIngredientTags,inputExecutionTimeTags;
  int _tags=0;//qt di tag totale
  RecipesIterator iterator;
  Cookbook cookbook;
  Set<Recipe> recipesFinded;

  //#endregion parametri di classe


  static TextStyle textRecipe = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic,color: Colors.black);

  SearchInLocalPageState(this.value){
      this.cookbook=new Cookbook();
      this.recipesFinded=new Set<Recipe>();
      this.totalTags=new Map<String,List<String>>();
      this.totalTags.putIfAbsent("name", ()=>_tagsName);
      this.totalTags.putIfAbsent("ing", ()=>_tagsIngredients);
      this.totalTags.putIfAbsent("time", ()=>_tagsExecutionTime);

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
                        this.iterator=cookbook.createIteratorByName(this.cookbook.getRecipes(), value.toString());
                        refresh();
                      }else{
                        _tagsName.add(value.toString());
                        this.iterator=cookbook.createIteratorByName(recipesFinded, value.toString());
                        refresh();
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
                        //TODO
                        researchAfterRemoval();
                      });
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
                        this.iterator=cookbook.createIteratorByIngredient(this.cookbook.getRecipes(), value.toString());
                        refresh();
                      }else{
                        _tagsIngredients.add(value.toString());
                        this.iterator=cookbook.createIteratorByIngredient(this.recipesFinded, value.toString());
                        refresh();
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
                        this.iterator=cookbook.createIteratorByTime(this.cookbook.getRecipes(), int.parse(value));
                        refresh();
                      }else{
                        if(_tagsExecutionTime.length>0){
                          _tagsExecutionTime.remove(value);
                        }
                        _tagsExecutionTime.add(value);
                        this.iterator=cookbook.createIteratorByTime(this.recipesFinded, int.parse(value));
                        refresh();
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
    print("si aggiorna");

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: this.recipesFinded.length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          Recipe r = this.recipesFinded.toList().elementAt(index);

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

  void refresh() {
    this.recipesFinded.clear();
    while(iterator.hasNext()) recipesFinded.add(iterator.next());
    this.iterator.reset();
  }

  void researchAfterRemoval() {
    int i=0;
    if(_tags==0)this.recipesFinded.clear();
    else {
      this.totalTags.entries.forEach((map) {
        if (map.key == "name" && map.value.length!=0) {
          map.value.forEach((value) {
            i==0 ? this.iterator = cookbook.createIteratorByName(this.cookbook.getRecipes(), map.value.elementAt(0).toString())
            : this.iterator = cookbook.createIteratorByName(this.recipesFinded, value.toString());
            i++;
            refresh();
          });
        }

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
        
        
      });
      if(i==0)this.recipesFinded.clear();
    }
  }


}

