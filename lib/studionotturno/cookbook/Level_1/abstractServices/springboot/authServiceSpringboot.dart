

import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/serviceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';

import '../authService.dart';

class AuthServiceSpringboot implements AuthService{

  ServiceSpringboot service;

  @override
  Future<bool> signin(Map<String, dynamic> userJson) async{
    this.service =new ServiceSpringboot();
    return await service.sendData(userJson, "/user/registration/");
  }

  @override
  Future<bool> signup(Map<String, dynamic> userJson) async{
    this.service =new ServiceSpringboot();
    return await service.sendData(userJson, "/user/login/");
  }

  Future<User> retrieveData(String email,String pass) async {
    this.service =new ServiceSpringboot();
    Map<String,dynamic> map=new Map<String,dynamic>();
    map.putIfAbsent("email", () => email);
    map.putIfAbsent("password", () => pass);
    User user= await service.retrieveData(map, "/user/getData/");
    return Future.value(user);
  }

}