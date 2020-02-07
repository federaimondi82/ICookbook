

import 'package:ricettario/domain/birthday.dart';

class User{
  String name;
  String surname;
  Birthday birthday;
  String gender;
  String email;
  String password;


  User(this.name,this.surname,this.birthday);


  User setName(String name){
    this.name=name;
    return this;
  }
  User setSurname(String surname){
    this.surname=surname;
    return this;
  }
  User setBirthday(Birthday birthday){
    this.birthday=birthday;
    return this;
  }
  User setGender(String gender){
    this.gender=gender;
    return this;
  }
  User setEmail(String email){
    this.email=email;
    return this;
  }
  User setPassword(String pass){
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