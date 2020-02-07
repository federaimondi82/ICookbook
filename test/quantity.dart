

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/birthday.dart';
import 'package:ricettario/domain/quantity.dart';
import 'package:ricettario/domain/unit.dart';
import 'package:ricettario/domain/unitRegister.dart';

import 'package:ricettario/main.dart';
import 'package:ricettario/domain/user.dart';

void main() {

  test ("Right singleton unitRegister",(){
    UnitRegister u1=new UnitRegister();
    UnitRegister u2=new UnitRegister();
    expect(u1,isNotNull);
    expect(u2,isNotNull);
    expect(u1,equals(u2));

  });
  test ("Unit Register not empty",(){
    UnitRegister u1=new UnitRegister();
    expect(u1,isNotNull);
    expect(u1.getUnits(), isNotNull);
    expect(u1.getUnits(), isNotEmpty);

  });

  test ("Right singleton unitRegister",(){
    UnitRegister u1=new UnitRegister();
    expect(u1.getUnits().elementAt(0).acronym,equals("gr"));

  });


}