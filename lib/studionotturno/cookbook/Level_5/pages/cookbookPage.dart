
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          //_searchDialog2(),
          new SearchDialogBlock(),
        ],),
      body: Center(
        child: RefreshIndicator(
            child: new RecipesListView(context),// _recipes(context),
            onRefresh: () async {
              await setState(() {
                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>CookbookPage()));
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