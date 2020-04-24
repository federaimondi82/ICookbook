
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import '../components/cookbookPage/recipesListView.dart';
import '../components/cookbookPage/searchDialogBlock.dart';

import 'recipePage.dart';

class CookbookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>CookbookPageState();
}

class CookbookPageState extends State<CookbookPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('ICookbook'),
        actions: <Widget>[
          new SearchDialogBlock(),
        ],),
      body: Center(
        child: RefreshIndicator(
            child: new RecipesListView(context),// _recipes(context),
            onRefresh: () async {
              await setState(() {
                Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new CookbookPage()),(Route<dynamic> route) => false,);
              });
            },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute( builder: (context) => RecipePage(null)),);
          },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey[900],
      ),
    );
  }

}
