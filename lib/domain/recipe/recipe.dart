
import 'package:ricettario/domain/ingredient/IngredientRegister.dart';
import 'package:ricettario/domain/ingredient/compositeIngredient.dart';
import 'package:ricettario/domain/ingredient/ingredient.dart';
import 'package:ricettario/domain/recipe/timer.dart';

///una ricetta è formata sia da ingredienti semplici (sale,olio ecc...) ma anche
/// da ingredienti composti ( es: impasto per la pizza che contiene farina,acqua,sale ecc...).
///Dovendo utilizzare istanze di Ingredient è anche il Creator di Ingredient,
///userà un registro di Factory o un Factory per gli ingredienti.
/// Dovendo memorizzare gli ingredienti è anche Information expert (grasp) degli ingredient
class Recipe {

  String name;
  String description;
  int difficult;
  List<Ingredient> ingredients;
  Timer executionTime;

  IngredientRegister ingredientRegister;

  Recipe(this.name){
    this.ingredients=new List<Ingredient>();
    ingredientRegister=new IngredientRegister();
    if(ingredientRegister.getIngredientFactories().length==0)ingredientRegister.loadFactories();
    executionTime=new Timer();
  }

  String getName(){
    return this.name;
  }
  String getDescription(){
    return this.description;
  }
  int getDifficult(){
    return this.difficult;
  }
  List<Ingredient> getIngredients(){
    return this.ingredients;
  }
  Timer getExecutionTime(){
    return this.executionTime;
  }
  void setName(String name){
    this.name=name;
  }
  void setDifficult(int difficult){
    this.difficult=difficult;
  }
  void setDescription(String description){
    this.description=description;
  }
  void setExecutionTime(Timer executionTime){
    this.executionTime=executionTime;
  }

  CompositeIngredient getIngredient(String name) {
    if(name==null || name=="") throw new Exception("Nome non valido");
    if(!containsByName(name)) throw new Exception("Ingrediente non presente");
    return ingredients.firstWhere((el)=>el.getName()==name);
  }

  Recipe add(Ingredient ingredient){
    if(ingredient==null) throw new Exception("Ingrediente null");
    if(contains(ingredient)) throw new Exception("Ingrediente già presente");
    this.ingredients.add(ingredient);
    return this;
  }

  Recipe addSimple(String name,double amount,String unit){
    this.ingredients.add(ingredientRegister.getFactory("simple").createIngredient(name, amount, unit));
    return this;
  }

  Recipe addComposite(String name,double amount,String unit){
    this.ingredients.add(ingredientRegister.getFactory("composite").createIngredient(name, amount, unit));
    return this;
  }

  bool contains(Ingredient ingredient) {
    if(ingredient==null) throw new Exception("Ingrediente null");
    return this.ingredients.contains(ingredient);
  }

  bool containsByName(String name) {
    if(name==null) throw new Exception("Ingrediente null");
    bool trovato=false;
    for (Ingredient el in this.ingredients) {
      if (el.getName() == name) trovato = true;
    }
    return trovato;
  }

  void remove(Ingredient ingredient) {
    if(ingredient==null) throw new Exception("Ingrediente null");
    if(!this.ingredients.contains(ingredient)) throw new Exception("Ingrediente non trovato");
    this.ingredients.remove(ingredient);
  }

  bool isEmpty(){
    return this.ingredients.isEmpty;
  }

  void clear(){
    this.ingredients.clear();
  }

  @override
  String toString() {
    return 'Recipe{name: $name, description: $description, difficult: $difficult, ingredients: $ingredients, executionTime: $executionTime}';
  }


}