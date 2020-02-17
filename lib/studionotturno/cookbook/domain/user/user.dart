

import 'package:ricettario/studionotturno/cookbook/domain/user/birthday.dart';

///
/// Classe software che identifica l'utente che utilizza l'applicazione.
/// All'utente sono associate le sue generalità tra cui la data di nascita, quindi
/// è creator e information Expert(pattern grasp)
/// di un Birthday
///
class User{

  String name;
  String surname;
  Birthday birthday;
  String gender;
  String email;
  String password;

  static final User _user=User._internal();

  User._internal();

  factory User(){
    return _user;
  }


  User setName(String name){
    this.name=name;
    return this;
  }
  User setSurname(String surname){
    this.surname=surname;
    return this;
  }
  User setBirthday(Birthday birthday){
    //TODO controlla da UserChecker
    this.birthday=birthday;
    return this;
  }
  User setGender(String gender){
    this.gender=gender;
    return this;
  }
  User setEmail(String email){
    //TODO controlla da UserChecker
    this.email=email;
    return this;
  }
  User setPassword(String pass){
    //TODO controlla da UserChecker
    this.password=pass;
    return this;
  }


  String getName(){
    return this.name;
  }
  String getSurname(){
    return this.surname;
  }
  Birthday getBirthday(){
    return this.birthday;
  }
  String getGender(){
    return this.gender;
  }
  String getEmail(){
    return this.email;
  }
  String getPassword() {
    return this.password;
  }

}