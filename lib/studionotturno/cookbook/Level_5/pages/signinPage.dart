

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

enum Gender { M, F }

class SigninPage extends StatefulWidget{

  User user;
  SigninPage(){
    this.user=new User();
    this.user.setName("");
    this.user.setSurname("");
    this.user.setEmail("");
    this.user.setPassword("");
  }
  @override
  State<StatefulWidget> createState()=>SigninPageState(this.user);
}

class SigninPageState extends State<SigninPage>{

  //ServicesRegister services;
  AuthServiceSpringboot auth;
  User user;
  var _name,_surname,_email,_password;
  Gender _gender=Gender.M;
  String alert="";
  SigninPageState(this.user);

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

    txtName= new TextEditingController(text: this.user.getName()==null?"Name":this.user.getName());
    txtSurname= new TextEditingController(text: this.user.getSurname()==null?"SurName":this.user.getSurname());
    txtEmail= new TextEditingController(text: this.user.getEmail()==null?"Email":this.user.getEmail());
    txtPass= new TextEditingController(text: this.user.getPassword()==null?"Pass":this.user.getPassword());

    final format = DateFormat("yyyy-MM-dd");
    Gender _gender;

    return new Scaffold(
      appBar: AppBar(
        leading: Icon(
            Icons.account_circle, size: iconSize, color: iconsColor),
        title: Text("Signin"),
      ),
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
                      myTextField(_name,"Name",(value)=>this.user.setName(value),txtName),
                      myTextField(_surname,"Surname",(value)=>this.user.setSurname(value),txtSurname),
                      genderRadio(),
                      Column(children: <Widget>[
                        Text('Birthday',style: labelStyle),
                        DateTimeField(
                          onChanged: (value){
                            setState(() {
                              Birthday b=new Birthday(value.day, value.month, value.year);
                              this.user.setBirthday(b);
                            });
                          },
                          format: format,
                          onShowPicker: (context, currentValue){
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ]),
                      //SizedBox(height: 24),
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
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          registration();
                        }
                      },
                      color: Colors.blueGrey[900],
                      highlightColor: Colors.lightGreenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Signin',style: labelStyle),
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

  void registration() async {
    try{
      UserChecker checker=new UserChecker();
      checker.controlBirthday(this.user.getBirthday());
      checker.controlEmail(this.user.getEmail());
      this.user.setPassword(checker.criptPassword(this.user.getPassword()));
      auth=ServicesRegister().getService("springboot").createServiceRegistration();
      bool result = await auth.signin(UserAdapter().setUser(user).toJson());
      if(result==true){

        this.alert="Registrato";
        FileManager fileManager=new FileManager();
        await fileManager.saveCacheFile(this.user);

        Future.delayed(new Duration(milliseconds: 1000),(){
          Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(builder:(BuildContext context)=>new CookbookPage()),(Route<dynamic> route) => false,);
          //Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>CookbookPage()));
        });
      }
    }
    catch(e){
      print(e);
      this.alert="Errore";
    }

  }

  Widget genderRadio() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Male'),
          leading: Radio(
            value: Gender.M,
            groupValue: _gender,
            onChanged: (Gender value) {
              this.user.setGender("M");
              setState(() {
                _gender=Gender.M;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female'),
          leading: Radio(
            value: Gender.F,
            groupValue: _gender,
            onChanged: (Gender value) {
              this.user.setGender("F");
              setState(() {
                _gender=Gender.F;
              });
            },
          ),
        ),
      ],
    );
  }

}
