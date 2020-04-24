

import 'dart:collection';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/abstractService.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/authService.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/authServiceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/fileManagement/fileManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/simpleIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/unit.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/unitRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/birthday.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/userChecker.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/compositeIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/executionTimeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/quantityAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/recipeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/simpleIngredientAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/unitAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userAdapter.dart';

void main() {

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

    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    bool result = await auth.signin(UserAdapter().setUser(u).toJson());
    expect(result,equals(true));

  });

  test("user login right all", () async {
    User u=new User();
    u.setEmail("marioverdi@gmail.com");
    u.setPassword("marioverdi");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));

    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    bool result=await auth.signup(UserAdapter().setUser(u).toJson());
    expect(result,equals(true));
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
    bool result=await auth.signup(UserAdapter().setUser(u).toJson());
    expect(result,equals(false));

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
    await auth.retrieveData(u.getEmail(),u.getPassword()).then((User user) async => await fileManager.saveCacheFile(user));

  });

}