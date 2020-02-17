

import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/unitRegister.dart';


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

  test("quantity instance 'quanto basta'",(){
    UnitRegister u1=new UnitRegister();
    Quantity q=new Quantity();//una quantità di "quanto basta"
    q.setAmout(0).setUnit(u1.getUnits().elementAt(0));
    expect(q, isNotNull);
    expect(q.getUnit().acronym,equals("gr"));

    print(q.toString());

  });


}