

import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/birthday.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/userChecker.dart';


void main() {

  test ("user singleton",(){
    User u=new User();
    User u2=new User();
    expect(u,isNotNull);
    expect(u2,isNotNull);
    expect(u==u2,equals(true));

  });

  test("Right toStringBirthday", () {
    User u=new User();
    u.setName("Mario");
    u.setSurname("Rossi");
    u.setBirthday(new Birthday(10, 10, 2010));
    expect(u.getBirthday().toString() , "10/10/2010");
  });

  test ("Right singleton UserChecker",(){
    UserChecker u1=new UserChecker();
    UserChecker u2=new UserChecker();
    expect(u1,isNotNull);
    expect(u2,isNotNull);
    expect(u1,equals(u2));

  });

  test("email vadidation",(){
    UserChecker u =new UserChecker();
    expect(u.controlEmail("una email abbastanza lunga"), equals(true));
  });

  test("email Exception_1",(){
    UserChecker u =new UserChecker();
    expect(()=>u.controlEmail(null), throwsException);
  });

  test("email Exception_2",(){
    UserChecker u =new UserChecker();
    expect(()=>u.controlEmail(""), throwsException);
  });

  test("email Exception_3",(){
    UserChecker u =new UserChecker();
    expect(()=>u.controlEmail("asd"), throwsException);
  });

  test("chiperPass Exception_1",(){
    UserChecker u =new UserChecker();
    expect(()=>u.criptPassword(null), throwsException);
  });

  test("chiperPass Exception_2",(){
    UserChecker u =new UserChecker();
    expect(()=>u.criptPassword(""), throwsException);
  });

  test("chiperPass not equals",(){
    UserChecker u =new UserChecker();
    expect(u.criptPassword("asdfghjkl"), isNotEmpty);
    expect(u.criptPassword("asdfghjkl"), isNotNull);
    expect(u.criptPassword("asdfghjkl"), isNot("asdfghjkl"));
  });

  test("Birthday exceptions",(){
    UserChecker u =new UserChecker();
    var now=new DateTime.now();
    Birthday b1=new Birthday(-1, 1, 2000);
    Birthday b2=new Birthday(32, 1, 2000);
    Birthday b3=new Birthday(1, 13, 2000);
    Birthday b4=new Birthday(1, -1, 2000);
    Birthday b5=new Birthday(1, 1, now.year-150);//nato 150 fa
    Birthday b6=new Birthday(1, 1, now.year-16);//nato 16 anni fa
    Birthday b7=new Birthday(1, 1, now.year+1); //nato l'anno prossimo
    Birthday b8=new Birthday(0, 1, 2000);
    Birthday b9=new Birthday(1, 0, 2000);
    Birthday b10=new Birthday(10, 10, 2000);


    expect(()=>u.controlBirthday(b1),throwsException);
    expect(()=>u.controlBirthday(b2),throwsException);
    expect(()=>u.controlBirthday(b3),throwsException);
    expect(()=>u.controlBirthday(b4),throwsException);
    expect(()=>u.controlBirthday(b5),throwsException);
    expect(()=>u.controlBirthday(b6),throwsException);
    expect(()=>u.controlBirthday(b7),throwsException);
    expect(()=>u.controlBirthday(b8),throwsException);
    expect(()=>u.controlBirthday(b9),throwsException);
    expect(u.controlBirthday(b10),equals(true));

  });

}
