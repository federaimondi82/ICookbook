
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ricettario/domain/user/birthday.dart';
///
/// Classe per controllare i dati inseriti dall'utente, consente anche di cifrare la password
///
///
class UserChecker{

  ///istanza static per il singleton
  static final UserChecker _checker=UserChecker._internal();

  UserChecker._internal();

  factory UserChecker(){
    return _checker;
  }

  ///
  /// Viene controllato se l'email è valida;
  /// Non deve essere nulla,vuota o minore di 8 caratteri
  ///
  bool controlEmail(String email){
    if(email==null) throw new Exception('email nulla');
    else if(email.isEmpty) throw new Exception('email vuota');
    else if(email.length<9) throw new Exception("Email troppo corta");
    return true;
  }

  ///
  /// Viene cifrata la password con un apposito algoritmo
  /// Non deve essere nulla vuota
  ///
  String criptPassword(String pass){
    if(pass==null) throw new Exception('pass nulla');
    else if(pass.isEmpty) throw new Exception('pass vuota');
    return md5.convert(utf8.encode(pass)).toString();
  }

  bool controlBirthday(Birthday birthday){
    var now=new DateTime.now();

    if(birthday==null) throw new Exception("data di nasciata nullo");
    else if(birthday.day>31 || birthday.day<1) throw new Exception("giorno errato");
    else if(birthday.month>12 || birthday.month<1) throw new Exception("mese errato");
    else if(birthday.year>now.year) throw new Exception("anno non valido");
    else if((now.year-birthday.year)<17 || (now.year-birthday.year)>100) throw new Exception("anno non valido");
    return true;
  }



}