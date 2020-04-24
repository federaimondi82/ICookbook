

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/authServiceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/birthday.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/userChecker.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';

import 'cookbookPage.dart';

class LoginPage extends StatefulWidget{

  User user;
  LoginPage(){
    this.user=new User();
    this.user.setName("");
    this.user.setSurname("");
    this.user.setEmail("");
    this.user.setPassword("");
  }
  @override
  State<StatefulWidget> createState()=>LoginPageState(this.user);
}

class LoginPageState extends State<LoginPage>{

  ServicesRegister services;
  AuthServiceSpringboot auth;
  User user;
  var _email,_password;
  String alert="";
  LoginPageState(this.user);

  //#region graphic

  final _formKey = GlobalKey<FormState>();//per la validazione della form

  static const TextStyle labelStyle=TextStyle(fontSize: 24,color: Colors.purple,fontWeight: FontWeight.bold,letterSpacing: 1.2);
  static const TextStyle textStyle=TextStyle(fontSize: 20,color: Colors.blueGrey,fontStyle: FontStyle.italic,letterSpacing: 1.2);
  static const Color iconsColor=Colors.blueGrey;
  static const double iconSize=40;

  static TextEditingController txtName,txtSurname,txtEmail,txtPass;

  //#endregion graphic

  @override
  Widget build(BuildContext context) {

    txtEmail= new TextEditingController(text: this.user.getEmail()==null?"Email":this.user.getEmail());
    txtPass= new TextEditingController(text: this.user.getPassword()==null?"Pass":this.user.getPassword());

    final format = DateFormat("yyyy-MM-dd");

    return new Scaffold(
      appBar: AppBar(
        leading: Icon(
            Icons.account_circle, size: iconSize, color: iconsColor),
        title: Text("Signup"),
      ),//SingleChildScrollView(
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child:Column(
                  children: <Widget>[
                    myTextField(_email,"Email",(value)=>this.user.setEmail(value),txtEmail),
                    myTextField(_password,"Password",(value)=>this.user.setPassword(value),txtPass),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: ButtonTheme(
                  height: 50,
                  minWidth: 200,
                  child: RaisedButton(
                    onPressed: ()async {
                      if(_formKey.currentState.validate()){
                        await login();
                      }
                    },
                    color: Colors.blueGrey[900],
                    highlightColor: Colors.lightGreenAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Signup',style: labelStyle),
                  ),
                ),
              ),
              Text(this.alert,style:TextStyle(fontSize: 20,color: Colors.red))
            ],
          ),
        ),
      ),
    );
  }

  Widget myTextField(Key key,String labelName,Function(String) function,TextEditingController controller){
    return TextFormField(
      key: key,
      style: textStyle,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: labelStyle,
      ),
      onChanged: function,
      controller: controller,
      obscureText: labelName=="Password"?true:false,
    );
  }

  void login() async {
    try{
      UserChecker checker=new UserChecker();
      checker.controlEmail(this.user.getEmail());
      this.user.setPassword(checker.criptPassword(this.user.getPassword()));
      //print(user.toString());
      ServicesRegister services=new ServicesRegister();
      AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
      bool result=await auth.signup(UserAdapter().setUser(this.user).toJson());

     // print(result);
      if(result==true){//utente autenticato
        setState(() async {
          this.alert="Rigth data";
          FileManager fileManager=new FileManager();
          await auth.retrieveData(this.user.getEmail(),this.user.getPassword())
              .then((User user) async => await fileManager.saveCacheFile(user));
          Future.delayed(new Duration(milliseconds: 1000),(){
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>CookbookPage()));
          });
        });
      }else{
        setState(() {
          this.alert="Wrong data";
        });
      }
    }
    catch(e){
      this.alert="Errore";
    }

  }
}
