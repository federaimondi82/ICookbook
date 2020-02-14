
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/domain/ingredient/ingredient.dart';
import 'package:ricettario/domain/ingredient/simpleIngredient.dart';
import 'package:ricettario/domain/ingredient/quantity.dart';
import 'package:ricettario/domain/ingredient/unitRegister.dart';

void main() {

  test("ingredient instances not equals or null",(){
    UnitRegister u1=new UnitRegister();

    Quantity q1=new Quantity();//una quantità di "quanto basta"
    q1.setAmout(0).setUnit(u1.getUnits().elementAt(0));
    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple1=new SimpleIngredient("sale",q1);//quanto basta
    SimpleIngredient simple2=new SimpleIngredient("farina",q2);//100gr di farina
    expect(simple1, isNotNull);
    expect(simple1.getName(),equals("sale"));
    expect(simple2.getName(),equals("farina"));
    expect(simple1,isNot(simple2));

  });

  test("compositeIngredient no accept other equals ingredients",(){
    UnitRegister u1=new UnitRegister();

    Quantity q1=new Quantity();//una quantità di "quanto basta"
    q1.setAmout(0).setUnit(u1.getUnits().elementAt(0));
    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple1=new SimpleIngredient("sale",q1);//quanto basta
    SimpleIngredient simple2=new SimpleIngredient("farina",q2);//100gr di farina

    CompositeIngredient comp=new CompositeIngredient("impasto per pizza",q2);
    expect(comp, isNotNull);
    expect(comp.lenght(), equals(0));
    expect(()=>comp.add(null),throwsException);
    expect(comp.lenght(), equals(0));
    comp.add(simple1);
    comp.add(simple2);
    expect(()=>comp.add(simple1),throwsException);
    expect(comp.lenght(), equals(2));
  });

  test("compositeIngredient no accept groups of equals ingredients",(){
    UnitRegister u1=new UnitRegister();

    Quantity q1=new Quantity();//una quantità di "quanto basta"
    q1.setAmout(0).setUnit(u1.getUnits().elementAt(0));
    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple1=new SimpleIngredient("sale",q1);//quanto basta
    SimpleIngredient simple2=new SimpleIngredient("farina",q2);//100gr di farina

    CompositeIngredient comp=new CompositeIngredient("impasto per pizza",q2);
    comp.add(simple1);
    comp.add(simple2);
    expect(comp.lenght(), equals(2));

    List<Ingredient> list =new List<Ingredient>();
    list.add(simple1);list.add(simple2);
    List<Ingredient> list2=null;


    expect(comp.addAll(list2),equals(false));//lista nulla
    expect(comp.addAll(list),equals(false));//lista con ingredienti già presenti
    expect(comp.lenght(), equals(2));
  });

  test("compositeIngredient remove ingredients",(){
    UnitRegister u1=new UnitRegister();
    Quantity q1=new Quantity();//una quantità di "quanto basta"
    q1.setAmout(0).setUnit(u1.getUnits().elementAt(0));
    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple1=new SimpleIngredient("sale",q1);//quanto basta
    SimpleIngredient simple2=new SimpleIngredient("farina",q2);//100gr di farina

    CompositeIngredient comp=new CompositeIngredient("impasto per pizza",q2);
    expect(comp.remove(null),equals(false));
    expect(comp.remove(simple1),equals(false));
    comp.add(simple1);
    comp.add(simple2);
    expect(comp.lenght(), equals(2));
    comp.remove(simple1);
    comp.remove(simple2);
    expect(comp.lenght(),equals(0));
  });

  test("compositeIngredient remove list of ingredients",(){
    UnitRegister u1=new UnitRegister();
    Quantity q1=new Quantity();//una quantità di "quanto basta"
    q1.setAmout(0).setUnit(u1.getUnits().elementAt(0));
    Quantity q2=new Quantity();//una quantità di "quanto basta"
    q2.setAmout(100).setUnit(u1.getUnits().elementAt(0));//100 gr

    SimpleIngredient simple1=new SimpleIngredient("sale",q1);//quanto basta
    SimpleIngredient simple2=new SimpleIngredient("farina",q2);//100gr di farina

    CompositeIngredient comp=new CompositeIngredient("impasto per pizza",q2);
    comp.add(simple1); comp.add(simple2);

    List<Ingredient> list =new List<Ingredient>();
    list.add(simple1); list.add(simple2);
    expect(comp.lenght(),equals(2));
    expect(comp.removeAll(null), equals(false));

    List<Ingredient> list2 =new List<Ingredient>();
    expect(comp.removeAll(list2), equals(false));
    list2.add(new SimpleIngredient("farina", q1));
    expect(comp.removeAll(list2), equals(false));
    expect(comp.lenght(),equals(2));

    comp.removeAll(list);
    expect(comp.lenght(),equals(0));
  });

  test("get ingredient by register",(){
    //TODO
  });

}
