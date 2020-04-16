

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/recipeMapperSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/localIterator/irecipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/components/cookbookPage/sendRecipeDialogComponent.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/recipePage.dart';

class RecipesListView extends StatefulWidget{

  BuildContext context;
  RecipesListView(this.context);

  @override
  State<StatefulWidget> createState()=>RecipesListViewState(context);

}
class RecipesListViewState extends State<RecipesListView>{

  Cookbook cookbook;
  BuildContext context;

  IRecipesIterator iterator;
  List<Recipe> orderedRecipes;

  RecipesListViewState(this.context){
    this.cookbook=new Cookbook();
  }

  @override
  Widget build(context) {

    List<LazyResource> map=new List<LazyResource>();
    User user=new User();
    if(user.getName()!=null){
      ///per il controllo con i nomi memorizzati in cloud
      RecipeMapper mapper=ServicesRegister().getService("springboot").createMapper();
      mapper.reloadProxy();
      map=mapper.getMapper();
    }


    //this.orderedRecipes.clear();

    return ListView.builder(
        itemCount: this.cookbook.getRecipes().length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          this.orderedRecipes=new List<Recipe>();
          this.iterator=cookbook.createIteratorAscending(this.cookbook.getRecipes());
          while(iterator.hasNext()) orderedRecipes.add(iterator.next());
          this.iterator.reset();
          Recipe r = this.orderedRecipes.elementAt(index);
          return ListTile(
            title: Text(r.getName().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30,fontStyle: FontStyle.italic,
                    color: map.where((el)=>el.getRecipeName().toString().contains(r.getName())).isNotEmpty? Colors.purple : Colors.black)
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => RecipePage(r)),
              );
            },
            onLongPress: () {
              showDialog(context: context,
                  child: new SendRecipeDialogComponent(context, r.getName()));//_sendRecipeDialog(context, r.getName()));
            },
            leading: const Icon(
                Icons.local_dining, size: 40.0, color: Colors.purple),
            subtitle: Text(
                r.getExecutionTime().toMinutes().toString() + " minutes"),
          );
        });
  }




}
