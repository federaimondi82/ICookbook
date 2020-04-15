

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';

// ignore: must_be_immutable
class SearchByIngredientPage extends StatefulWidget{

  Recipe recipe;
  SearchByIngredientPage(this.recipe);

  @override
  State<StatefulWidget> createState()=>SearchByIngredientState(this.recipe);

}

class SearchByIngredientState extends State<SearchByIngredientPage>{

  Recipe recipe;
  final List<String> _tagsIngredient=[];
  List<Ingredient> listOfIngredient,list;
  List<Ingredient> selectedIngredient;
  int _tags=0;
  var inputIngredientName;
  Cookbook cookbook;

  static const TextStyle textStyle = TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.purple);
  static const TextStyle labelStyle=TextStyle(fontSize: 24,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2);
  static const TextStyle singleRowStyleText=TextStyle(fontSize: 24);

  SearchByIngredientState(this.recipe){
    this.cookbook=new Cookbook();
    this.list=new List<Ingredient>();
    this.listOfIngredient=new List<Ingredient>();
    this.selectedIngredient=new List<Ingredient>();
  }

  //#region methods

  ///consente di aggiungere ad un set di ingredienti un ingrediente cercato
  ///viene cercato l'ingrediente anche all'interno dei composti
  ///un ingrediente uguale ad uno già nella lista non verrà aggiunto
  void contains(Recipe recipe,String name) {
    recipe.getIngredients().forEach((ing){
      if(ing is SimpleIngredient)  if(ing.getName().toString().contains(name)) this.list.add(ing);

      if(ing is CompositeIngredient){
        if(ing.getName().toString().contains(name)) this.list.add(ing);
        ing.getIngredients().forEach((simple){
          if(simple.getName().toString().contains(name)) this.list.add(ing);
        });
      }
    });

  }

  List<Ingredient> searchIngredient(){
    this.list.clear();
    print("1.1");
    _tagsIngredient.forEach((el){
      for(Recipe recipe in cookbook.getRecipes()) contains(recipe,el);
    });
    print("1.2");
    return this.list;
  }

  List<Ingredient> rebuildList() {
    List<Ingredient> l=[];
    this.listOfIngredient.forEach((ing){
      if(this.selectedIngredient.contains(ing))l.add(ing);
    });
    return l;
  }

  void retrieveIngredietFromPage() {
    this.selectedIngredient.forEach((el)=>print(el.toString()));
  }

  void addIngredientToRecipe() {}
  //endregion methods

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Search ingredient",style:TextStyle(fontSize: 20)),
        iconTheme: IconThemeData(color: Colors.purple),
        leading: Icon(Icons.kitchen),
      ),
        body:SingleChildScrollView(
          child:Column(
            children: <Widget>[
              Tags(
                key: inputIngredientName,
                textField: TagsTextField(
                    lowerCase: true,
                    duplicates: false,
                    width: 600,
                    hintText: "Search by ingredient name....",
                    hintTextColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20,color: Colors.purple),
                    onSubmitted: (value){
                      print("1");
                      setState(() {
                        _tagsIngredient.add(value);
                        _tags++;
                        this.listOfIngredient=searchIngredient();
                        print("2");
                      });
                    }
                ),
                itemCount: _tagsIngredient.length,
                itemBuilder: (int index){
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    combine: ItemTagsCombine.withTextAfter,
                    title: _tagsIngredient.elementAt(index).toString(),
                    activeColor: Colors.blueGrey[900],
                    textActiveColor: Colors.purple,
                    textStyle: TextStyle(fontSize: 20),
                    icon: ItemTagsIcon(
                      icon: Icons.room_service,
                    ),
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: (){
                        setState(() {
                          _tagsIngredient.removeAt(index);
                          _tags--;
                          this.listOfIngredient=searchIngredient();

                          this.selectedIngredient=rebuildList();

                        });
                        //required
                        return true;
                      },
                    ),
                  );
                },
              ),
              Container(
                height: 400,
                color: Colors.white70,
                padding: EdgeInsets.all(10),
                child:_recipesWidget(context),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ButtonTheme(
                  height: 50,
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: (){
                      retrieveIngredietFromPage();
                      addIngredientToRecipe();
                    },
                    color: Colors.blueGrey[900],
                    highlightColor: Colors.lightGreenAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Add ingredients',style: labelStyle),
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }

  Widget _recipesWidget(BuildContext context){
    print("3");
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: this.listOfIngredient.length,
        addSemanticIndexes: false,
        itemBuilder: (context, index) {
          //SIMPLE INGREDIENT
          print('qui');
          var rng = new Random();
            if(this.listOfIngredient[index] is SimpleIngredient){
              print("simple");
              return Padding(
                key: new ObjectKey(rng.nextInt(1000)),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      tristate: true,
                      value: this.selectedIngredient.contains(this.listOfIngredient[index]),
                      onChanged: ((value){
                        setState(() {
                          this.selectedIngredient.contains(this.listOfIngredient[index])?this.selectedIngredient.remove(this.listOfIngredient[index]):this.selectedIngredient.add(this.listOfIngredient[index]);
                        });
                      }),
                    ),
                    Text(this.listOfIngredient[index].getName(),style: singleRowStyleText),
                  ],
                ),
              );
            }
            else { //COMPOSITE INGREDIENT
              print("comp");
              //return Text("comp");
              return new SimpleGroupedCheckbox<Ingredient>(
                key: new ObjectKey(rng.nextInt(1000)),
                itemsTitle: (this.listOfIngredient[index] as CompositeIngredient).getIngredients().map((el)=>el.getName()).toList(),
                values: (this.listOfIngredient[index] as CompositeIngredient).getIngredients(),
                preSelection: [],
                activeColor: Colors.green,
                groupTitle: this.listOfIngredient[index].getName(),
                checkFirstElement: true,
                multiSelection: true,
                onItemSelected: (data){
                  print(data);
                  /*setState(() {
                    this.selectedIngredient.contains(this.listOfIngredient[index])?this.selectedIngredient.remove(this.listOfIngredient[index]):this.selectedIngredient.add(this.listOfIngredient[index]);
                  });*/
                },
                isExpandableTitle: true,
              );
            }
        });
  }

}