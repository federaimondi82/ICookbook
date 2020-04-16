

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/cookbookPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/loginPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/searchInCloudPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/searchInLocalPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/settingPage.dart';
import 'package:ricettario/studionotturno/cookbook/Level_5/pages/signinPage.dart';

class SearchDialogBlock extends StatelessWidget{

  static const double iconsSize=20.0;
  static const Color iconsColor=Colors.blueGrey;
  static const TextStyle textStyle=TextStyle(fontSize: 20,color: Colors.purple);
  User user=new User();

  @override
  Widget build(BuildContext context) {

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
            title: Text("Search in cloud",style: textStyle),
            leading: const Icon(Icons.search, size: iconsSize, color: iconsColor),
            onTap: (){
              //Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new SearchInCloudPage()),(Route<dynamic> route) => false,);
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SearchInCloudPage()),);
            },
          ),
        ),
        showSetting(context),
        showLogin(context),
        showRegistration(context),
        showLogout(context),
      ],
    );
  }

  Widget showSetting(BuildContext context){
    if(user.getName()!=null){
      return PopupMenuItem<ListTile>(
        child: ListTile(
          title: Text("Setting",style: textStyle),
          leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
          onTap: (){
            //Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new SettingPage()),(Route<dynamic> route) => false,);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SettingPage()),);
          },
        ),
      );
    }
  }

  Widget showRegistration(BuildContext context){
    if(user.getName()==null){
      return PopupMenuItem<ListTile>(
        child: ListTile(
          title: Text("Registration",style: textStyle),
          leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
          onTap: (){

            //Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new SigninPage()),(Route<dynamic> route) => false,);
            Navigator.push(context,MaterialPageRoute(builder: (context) =>  SigninPage()),);
          },
        ),
      );
    }
  }

  Widget showLogin(BuildContext context){
    if(user.getName()==null){
      return PopupMenuItem<ListTile>(
        child: ListTile(
          title: Text("Login",style: textStyle),
          leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
          onTap: (){
            //Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new LoginPage()),(Route<dynamic> route) => false,);
            Navigator.push(context,MaterialPageRoute(builder: (context) =>  LoginPage()),);
          },
        ),
      );
    }
  }

  Widget showLogout(BuildContext context){
    if(user.getName()!=null){
      return PopupMenuItem<ListTile>(
        child: ListTile(
          title: Text("Logout",style: textStyle),
          leading: const Icon(Icons.settings, size: iconsSize, color: iconsColor),
          onTap: (){
            FileManager fileManager=new FileManager();
            Future<bool> result=fileManager.deleteCache();
            User user=new User();
            user.deleteAll();
            Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new CookbookPage()),(Route<dynamic> route) => false,);
            //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  CookbookPage()),);
          },
        ),
      );
    }
  }
}