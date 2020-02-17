
import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/compositeIngredientFactory.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/simpleIngredientFactory.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';

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
    /*reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);*/

    expect(reg2.size(),equals(2));
  });

  test("IngredientRegister remove Factory",(){
    IngredientRegister reg3=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    /*reg3.addFactory("simple",simple);
    reg3.addFactory("composite",composite);*/

    reg3.removeFactory("simple");
    expect(reg3.size(),equals(1));
  });

  /*test("IngredientRegister add exception",(){
    IngredientRegister reg1=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();

    expect(()=>reg1.addFactory("", simple),throwsException);
    expect(()=>reg1.addFactory(null, simple),throwsException);
    expect(()=>reg1.addFactory("simple", null),throwsException);

    //reg1.addFactory("simple", simple);
    expect(()=>reg1.addFactory("simple", simple),throwsException);

    expect(reg1.size(),equals(1));
  });*/

  test("IngredientRegister remove exceptions",(){
    IngredientRegister reg1=new IngredientRegister();

    SimpleIngredientFactory simple=new SimpleIngredientFactory();
    CompositeIngredientFactory composite=new CompositeIngredientFactory();
    /*reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);*/

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
    /*reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);*/
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
    /*reg1.addFactory("simple",simple);
    reg1.addFactory("composite",composite);*/

    Ingredient ing1=reg1.getFactory("composite").createIngredient("impasto per pizza", 500, "gr");
    if(ing1 is CompositeIngredient){
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("farina 00", 200, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("lievito di birra", 5, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("sale", 10, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("olio", 35, "gr"));
      (ing1 as CompositeIngredient).add(SimpleIngredientFactory().createIngredient("acqua", 300, "ml"));
    }

    Recipe recipe1=new Recipe("pizza margherita");
    expect(recipe1,isNotNull);

    recipe1.addSimple("polpa pomodoro", 1, "l")
    .addSimple("mozzarella", 100, "gr")
    .addSimple("basilico", 0, "gr");

    recipe1.addComposite("impasto per pizza", 500, "gr");
    recipe1.getIngredient("impasto per pizza")
        .addByParameter("farina 00", 200, "gr")
        .addByParameter("lievito di birra", 5, "gr")
        .addByParameter("sale", 10, "gr")
        .addByParameter("olio", 35, "gr")
        .addByParameter("acqua", 300, "ml");

    expect(recipe1.getIngredient("impasto per pizza").equals(ing1),equals(true));

    expect(()=>recipe1.add(null),throwsException);
    expect(()=>recipe1.add(ing1),throwsException);
    expect(()=>recipe1.contains(null),throwsException);

    expect(()=>recipe1.remove(null),throwsException);
    recipe1.remove(ing1);

    expect(recipe1.contains(ing1),equals(false));
    expect(()=>recipe1.remove(ing1),throwsException);

  });

}
