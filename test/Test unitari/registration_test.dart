

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/authServiceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/birthday.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/userChecker.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userJwtDataAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  test("user registration_1", () async {
    User u=new User();
    u.setName("Mario");    u.setSurname("Rossi");
    u.setBirthday(new Birthday(10, 10, 2000));
    u.setGender("M");    u.setEmail("MarioRossi"+Random().nextInt(90000).toString()+"@gmail.com");
    u.setPassword("asd");
    UserChecker checker=new UserChecker();
    checker.controlBirthday(u.getBirthday());
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));
    print(u.toString());
    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    bool result = await auth.signin(UserAdapter().setUser(u).toJson());
    expect(result,equals(true));

  });

  test("user login right all", () async {
    User u=new User();
    u.setEmail("marioverdi@gmail.com"); u.setPassword("marioverdi");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));

    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    Object obj=UserJwtDataAdapter().setUser(u).toJson();
    Response response = await http.post("http://localhost:8080/user/public/login/",
        body: jsonEncode(<String,dynamic>{"data":obj}),
        encoding: Encoding.getByName("utf-8"));

    String token=response.headers.entries.firstWhere((element) => element.key=="token").value;
    print("token in input: "+token);
    FileManager fileManager=new FileManager();
    await fileManager.saveToken(token);

    /*String t=await fileManager.readJWT();
    print("token saved: "+t);*/

  });

  test("user login wrongPass", () async {
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marco");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));

    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    //todo signin modificato
    /*bool result=await auth.signup(UserAdapter().setUser(u).toJson());
    expect(result,equals(false));*/

  });

  test("retrieve data from Backend",() async {
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    u.setPassword(checker.criptPassword(u.getPassword()));

    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();

    FileManager fileManager=new FileManager();
    //await auth.retrieveData(u.getEmail(),u.getPassword()).then((User user) async => await fileManager.saveCacheFile(user));
    //todo rifare test

  });

}