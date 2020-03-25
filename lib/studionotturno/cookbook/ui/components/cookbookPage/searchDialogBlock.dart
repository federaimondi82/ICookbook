

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/ui/pages/searchInLocalPage.dart';

class SearchDialogBlock extends StatelessWidget{

  static const double iconsSize=20.0;
  static const Color iconsColor=Colors.blueGrey;
  static const TextStyle textStyle=TextStyle(fontSize: 20,color: Colors.purple);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return PopupMenuButton<ListTile>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ListTile>>[
        PopupMenuItem<ListTile>(
          child: ListTile(
            title: Text("Search in local...",style: textStyle),
            leading: const Icon(Icons.search, size: iconsSize, color: iconsColor),
            onTap: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SearchInLocalPage(0)),);
            },
          ),
        ),
        PopupMenuItem<ListTile>(
          child: ListTile(
            title: Text("Search in cloud...",style: textStyle),
            leading: const Icon(Icons.search, size: iconsSize, color: iconsColor),
            onTap: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SearchInLocalPage(1)),);
            },
          ),
        ),
        PopupMenuItem<ListTile>(
          child: ListTile(
            title: Text("Settings",style: textStyle),
            leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
            onTap: (){
              //TODO pagina setting
            },
          ),
        ),
      ],
    );
  }

}