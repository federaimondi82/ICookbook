

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/proxyFirestore/proxyPersonalFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
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

  RecipesListViewState(this.context){
    this.cookbook=new Cookbook();
  }

  @override
  Widget build(context) {

    ///per il controllo con i nomi memorizzati in cloud
    ProxyPersonalFirestore proxy=new ProxyPersonalFirestore();
    proxy.reloadProxy();
    Map<String,String> map=proxy.getMapper();

    return ListView.builder(
        itemCount: this.cookbook.getRecipes().length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          Recipe r = this.cookbook.getRecipes().elementAt(index);
          return ListTile(
            title: Text(r.getName().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 30,fontStyle: FontStyle.italic,
                    color: map.values.contains(r.getName())? Colors.purple : Colors.black)
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
