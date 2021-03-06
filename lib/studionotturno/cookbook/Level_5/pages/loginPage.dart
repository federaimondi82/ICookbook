

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/authServiceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/jwtToken.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/userChecker.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userJwtDataAdapter.dart';

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

    txtEmail= new TextEditingController(text: this.user.getEmail()==""?"marconeri@gmail.com":this.user.getEmail());
    txtPass= new TextEditingController(text: this.user.getPassword()==""?"marconeri":this.user.getPassword());

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

  ///Implementazione della procedur di autenticazione e ricezione del token JWT
  ///memorizzato poi in locale e riusato ogni volta per le comunicazioni
  void login() async {
    try{
      //preparazione dei dati utente da inviare per l'autenticazione
      UserChecker checker=new UserChecker();
      checker.controlEmail(this.user.getEmail());
      this.user.setPassword(checker.criptPassword(this.user.getPassword()));
      ServicesRegister services=new ServicesRegister();
      AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
      FileManager fileManager=new FileManager();
      //se l'utente è stato utenticato il server ha risposto con un token JWT
      await auth.signup(UserJwtDataAdapter().setUser(this.user).toJson()).then((result) async{
        if(result!=""){
          this.alert="Rigth data";
          //se il server ha risposto correttamente il token viene salvato in locale
          await fileManager.saveToken(result).whenComplete(() async {
            String t=await JwtToken().getToken();
            print("t: "+t);
            setState(() async {
              Future.delayed(new Duration(milliseconds: 1500),(){
                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>CookbookPage()));
              });
            });
          });
        }
        else setState(()=>this.alert="Wrong data");
        await fileManager.saveToken(result);
      });
    }
    catch(e){
      this.alert="Errore";
    }
  }

}
