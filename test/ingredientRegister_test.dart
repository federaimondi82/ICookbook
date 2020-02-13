
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/domain/ingredient/compositeIngredientFactory.dart';
import 'package:ricettario/domain/ingredient/ingredient.dart';
import 'package:ricettario/domain/ingredient/simpleIngredientFactory.dart';
import 'package:ricettario/domain/recipe/recipe.dart';

void main() {


  setUp((){
    IngredientRegister reg1=new IngredientRegister();
    reg1.clear();
  });

  test("IngredientRegister is Singleton",(){
    IngredientRegister reg1=new IngredientRegister();
    IngredientRegister reg2=new IngredientRegister();

    expect(reg1==reg2, equals(true));
    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);

    expect(reg2.size(),equals(2));
  });

  test("IngredientRegister remove Factory",(){
    IngredientRegister reg3=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    reg3.addFactory("simple",simple);
    reg3.addFactory("composite",composite);

    reg3.removeFactory("simple");
    expect(reg3.size(),equals(1));
  });

  test("IngredientRegister add exception",(){
    IngredientRegister reg1=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();

    expect(()=>reg1.addFactory("", simple),throwsException);
    expect(()=>reg1.addFactory(null, simple),throwsException);
    expect(()=>reg1.addFactory("simple", null),throwsException);

    reg1.addFactory("simple", simple);
    expect(()=>reg1.addFactory("simple", simple),throwsException);

    expect(reg1.size(),equals(1));
  });

  test("IngredientRegister remove exceptions",(){
    IngredientRegister reg1=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);

    expect(()=>reg1.removeFactory(""),throwsException);
    expect(()=>reg1.removeFactory(null),throwsException);
    expect(()=>reg1.removeFactory("simpleBlaBlaBla"),throwsException);

    reg1.removeFactory("simple");

    expect(reg1.size(),equals(1));
  });

  test("new recipe by Register",(){
    IngredientRegister reg1=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);
    expect(reg1.size(),equals(2));

    Recipe rep1=new Recipe("pizza margherita");
    rep1.addSimple("polpa pomodoro", 1, "l");
    rep1.addSimple("mozzarella", 100, "gr");
    rep1.addSimple("basilico", 0, "gr");

    rep1.addComposite("impasto pizza", 500, "gr");
    

    Ingredient ing1=reg1.getFactory("composite").createIngredient("impasto pizza", 500, "gr");
    if(ing1 is CompositeIngredient){
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    }

  });

  test("new Reciper By factory Exceptions",(){
    IngredientRegister reg1=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);

    Ingredient ing1=reg1.getFactory("composite").createIngredient("impasto pizza", 500, "gr");
    if(ing1 is CompositeIngredient){
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    }

    Ingredient ing2=reg1.getFactory("simple").createIngredient("polpa pomodoro", 1, "l");
    Ingredient ing3=reg1.getFactory("simple").createIngredient("mozzarella", 100, "gr");
    Ingredient ing4=reg1.getFactory("simple").createIngredient("basilico", 0, "gr");

    Recipe rep1=new Recipe("pizza margherita");
    expect(rep1,isNotNull);
    rep1.add(ing1).add(ing2).add(ing3).add(ing4);

    expect(()=>rep1.add(null),throwsException);
    expect(()=>rep1.add(ing1),throwsException);
    expect(()=>rep1.contains(null),throwsException);

    expect(()=>rep1.remove(null),throwsException);
    rep1.remove(ing1);
    expect(()=>rep1.remove(ing1),throwsException);

  });

}
