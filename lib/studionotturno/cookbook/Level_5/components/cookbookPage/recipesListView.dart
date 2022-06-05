

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/localIterator/irecipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/components/cookbookPage/sendRecipeDialogComponent.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/recipePage.dart';

class RecipesListView extends StatefulWidget{

  BuildContext context;
  List<LazyResource> map;
  RecipesListView(this.context);

  @override
  State<StatefulWidget> createState()=>RecipesListViewState(this.context);

}
class RecipesListViewState extends State<RecipesListView>{

  Cookbook cookbook;
  BuildContext context;
  List<LazyResource> map;
  IRecipesIterator iterator;
  Set<Recipe> orderedRecipes;
  RecipeMapper mapper;
  User user;
  Future<List<LazyResource>> fut;

  RecipesListViewState(this.context){
    this.cookbook=new Cookbook();
    this.user=new User();
    this.orderedRecipes=new Set<Recipe>();
    this.iterator=cookbook.createIteratorAscending(this.cookbook.getRecipes());
    while(iterator.hasNext()) orderedRecipes.add(iterator.next());
    this.iterator.reset();
  }

  @override
  void initState() {
    super.initState();
    if(user.getName()!=null){
      this.mapper=ServicesRegister().getService("springboot").createMapper();
      ///per il controllo con i nomi memorizzati in cloud
      this.fut= this.mapper.reloadProxy();
      this.map= mapper.getMapper();
    }
  }

  @override
  Widget build(context) {
    if(this.user.getName()!=null){
      print("SI mapper");
      return FutureBuilder<List<LazyResource>>(
        future: this.fut,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(snapshot.connectionState==ConnectionState.done){
            return listView();
          }
          else return null;
        },
      );
    }
    else {
      print("NO mapper");
      return listView();
    }

  }


  Widget listView(){
    return ListView.builder(
        itemCount: this.cookbook.getRecipes().length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          Recipe r = this.orderedRecipes.elementAt(index);
          return ListTile(
            title: Text(r.getName().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30,fontStyle: FontStyle.italic,
                    color: this.map==null?Colors.black
                      :
                    this.map.where((el)=>el.getRecipeName().toString().contains(r.getName())).isNotEmpty? Colors.purple : Colors.black)
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => RecipePage(r)),
              );
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context){
                    return SendRecipeDialogComponent(context, r.getName());
                });//_sendRecipeDialog(context, r.getName()));
            },
            leading: const Icon(
                Icons.local_dining, size: 40.0, color: Colors.purple),
            subtitle: Text(
                r.getExecutionTime().toMinutes().toString() + " minutes"),
          );
        });
  }



}
