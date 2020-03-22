

import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/recipeAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/target.dart';

class CookbookAdapter extends Target{

  Cookbook cookBook;

  CookbookAdapter(this.cookBook);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return null;
  }

  @override
  Object toObject(Map data) {
    //Recipe r=RecipeAdapter().toObject(data);
    cookBook.addRecipeObject(RecipeAdapter().toObject(data));
    // TODO: implement toObject
    return null;
  }

}