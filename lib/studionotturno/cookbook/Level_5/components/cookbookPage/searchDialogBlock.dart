

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/register_page.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/searchInLocalPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/signin_page.dart';

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
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SearchInLocalPage()),);
            },
          ),
        ),
        PopupMenuItem<ListTile>(
          child: ListTile(
            title: Text("Search in cloud(Not implemented yet)",style: textStyle),
            leading: const Icon(Icons.search, size: iconsSize, color: iconsColor),
            onTap: (){
              //TODO
              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SearchInCloudPage()),);
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
        PopupMenuItem<ListTile>(
          child: ListTile(
            title: Text("Registration.unimplemented",style: textStyle),
            leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
            onTap: (){
              //TODO
              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  RegisterPage()),);
            },
          ),
        ),
        PopupMenuItem<ListTile>(
          child: ListTile(
            title: Text("Login.unimplemented",style: textStyle),
            leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
            onTap: (){
              //TODO
              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SignInPage()),);
            },
          ),
        ),
      ],
    );
  }

}