
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipesIterator.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/recipeIteratorCloud.dart';
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/ingredient.dart';
import 'package:ricettario/studionotturno/cookbook/domain/Iterator/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/domain/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/domain/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/proxyPersonalFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/documentAdapter.dart';

///Responsabilità di effettuare ricerche di ingedienti e ricette nel ricettario
///E' possibile effettuare ricerche multiple
class ConcreteIteratorCloud implements RecipeIteratorCloud{

  static Cookbook cookBook;
  static List<Recipe> list;
  final firestore=Firestore.instance;
  User user;


  ConcreteIteratorCloud(){
    if(cookBook==null) cookBook=new Cookbook();
    if(list==null) list=new List<Recipe>();
    user=new User();
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  List<Recipe> getRecipes() {
    // TODO: implement getRecipes
    return null;
  }

  @override
  Future<List<Recipe>> searchByDifficult(int difficult) {
    // TODO: implement searchByDifficult
    return null;
  }

  @override
  Future<List<Recipe>> searchByExecutionTime(int minutes) {
    // TODO: implement searchByExecutionTime
    return null;
  }

  @override
  Future<List<Recipe>> searchByIngredient(Ingredient ingredient) {
    // TODO: implement searchByIngredient
    return null;
  }

  @override
  Future<List<Recipe>> searchByIngredientName(String name) {
    // TODO: implement searchByIngredientName
    return null;
  }

  @override
  Future<List<Recipe>> searchByIngredients(List<Ingredient> ingredients) {
    // TODO: implement searchByIngredients
    return null;
  }

  @override
  Future<List<Recipe>> searchByRecipeName(String name) {
    if(name=="" || name==null) throw new Exception("nome non valido");
    firestore.collection('recipes').where('recipeName',isEqualTo: name)
        .getDocuments().then((docs){
      docs.documents.forEach((doc){
        list.add(DocumentAdapter(null).toObject(doc.data));
      });
    });
    return Future.value(list);
  }

  @override
  Future<List<Recipe>> thenByDifficult(int difficult) {
    // TODO: implement thenByDifficult
    return null;
  }

  @override
  Future<List<Recipe>> thenByExecutionTime(int minutes) {
    // TODO: implement thenByExecutionTime
    return null;
  }

  @override
  Future<List<Recipe>> thenByIngredient(Ingredient ingredient) {
    // TODO: implement thenByIngredient
    return null;
  }

  @override
  Future<List<Recipe>> thenByIngredients(List<Ingredient> ingredients) {
    // TODO: implement thenByIngredients
    return null;
  }

  @override
  Future<List<Recipe>> thenByIngrendientName(String name) {
    // TODO: implement thenByIngrendientName
    return null;
  }

  @override
  Future<List<Recipe>> thenByRecipeName(String name) {
    // TODO: implement thenByRecipeName
    return null;
  }


}
