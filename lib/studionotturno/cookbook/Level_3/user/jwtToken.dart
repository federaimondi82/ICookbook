

import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';

///Classe responsabile di caricare e rilasciare il token
///E' una classe singleton, una sola istanza per la gestione del token
class JwtToken{

  static Future<String> token;

  static final JwtToken _jwtToken=JwtToken._internal();

  JwtToken._internal();

  factory JwtToken(){
    if(token==null){
      FileManager fileManager=new FileManager();
      token=fileManager.readJWT();
      //token.then((value) => print(value));
    }
    return _jwtToken;
  }

  Future<String> getToken(){
    return token;
  }





}