

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/birthday.dart';

import 'package:ricettario/main.dart';
import 'package:ricettario/domain/user.dart';

void main() {

  test ("user not null",(){
    User u=new User("mario", "rossi", new Birthday(10, 10, 2010));
    expect(u,isNotNull);

  });

  test("Right toStringBirthday", () {
    User u=new User("mario", "rossi", new Birthday(10, 10, 2010));
    expect(u.getBirthday().toString() , "10/10/2010");
  });

}
