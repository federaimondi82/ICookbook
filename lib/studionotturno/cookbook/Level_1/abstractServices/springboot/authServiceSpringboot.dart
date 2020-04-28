

import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/serviceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';

import '../authService.dart';
///
/// Servizio di autenticazione con backend Springboot;<br>
/// classe per gestire le chiamate di login e registrazione con backend Springboot
///
class AuthServiceSpringboot implements AuthService{

  ServiceSpringboot service;

  @override
  Future<bool> signin(Map<String, dynamic> userJson) async{
    this.service =new ServiceSpringboot();
    return await service.sendData(userJson, "/user/public/registration/");
  }

  @override
  Future<String> signup(Map<String, dynamic> userJson) async{
    this.service =new ServiceSpringboot();
    return await service.retrieveToken(userJson, "/user/public/login/");
  }

  Future<User> retrieveData(Map<String, dynamic> userJson) async {
    this.service =new ServiceSpringboot();
    User user= await service.retrieveData(userJson, "/user/getData/");
    return Future.value(user);
  }

}