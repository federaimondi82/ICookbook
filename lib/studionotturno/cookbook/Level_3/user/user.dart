


import 'birthday.dart';

///
/// Classe software che identifica l'utente che utilizza l'applicazione.
/// All'utente sono associate le sue generalità tra cui la data di nascita, quindi
/// è creator e information Expert(pattern grasp)
/// di un Birthday
///
class User{

  String name,surname,gender,email,password;
  Birthday birthday;

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
    //return "federaimondi27033@gmail.com";
    return this.email;
  }
  String getPassword() {
    return this.password;
  }

  @override
  String toString() {
    return 'User{name: $name, surname: $surname, gender: $gender, email: $email, password: $password, birthday: $birthday}';
  }

  void deleteAll() {
    this.setName(null).setSurname(null).setBirthday(null).setEmail(null).setPassword(null).setGender(null);
  }
}