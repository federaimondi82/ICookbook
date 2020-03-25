

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/proxyPersonalFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/ui/components/cookbookPage/sendRecipeDialogComponent.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/recipePage.dart';

class RecipesListView extends StatefulWidget{

  BuildContext context;
  RecipesListView(this.context);

  @override
  State<StatefulWidget> createState()=>RecipesListViewState(context);

}
class RecipesListViewState extends State<RecipesListView>{

  Cookbook _cookBook;
  BuildContext context;

  RecipesListViewState(this.context){
    _cookBook=new Cookbook();
  }

  @override
  Widget build(context) {

    ///per il controllo con i nomi memorizzati in cloud
    ProxyPersonalFirestore proxy=new ProxyPersonalFirestore();
    proxy.reloadProxy();
    Map<String,String> map=proxy.getMapper();
    
    //map.entries.forEach((el)=>print(el.key+"-"+el.value));

    return ListView.builder(
        itemCount: _cookBook.getRecipes().length,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          Recipe r = _cookBook.getRecipes().elementAt(index);
          print(map.values.contains(r.getName()));
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