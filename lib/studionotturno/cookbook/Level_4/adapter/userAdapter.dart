

import 'package:ricettario/studionotturno/cookbook/Level_3/user/birthday.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/target.dart';

class UserAdapter implements Target{

  User user;

  UserAdapter();

  UserAdapter setUser(User user){
    this.user=user;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": this.user.getName(),
      "surname": this.user.getSurname(),
      "gender": this.user.getGender(),
      "email": this.user.getEmail(),
      "password":this.user.getPassword(),
      "birthday":this.user.getBirthday().toString()
    };
  }

  @override
  User toObject(Map<dynamic, dynamic> data) {
    this.user.name = data['name'];
    this.user.surname = data['surname'];
    this.user.gender = data['gender'];
    this.user.email = data['email'];
    this.user.password = data['password'];
    List<String> birth = data['birthday'].toString().split("/");
    Birthday b = new Birthday(int.parse(birth.elementAt(2)),int.parse(birth.elementAt(1)),int.parse(birth.elementAt(0)));
    this.user.setBirthday(b);
    return this.user;
  }


}