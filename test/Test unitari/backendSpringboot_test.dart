
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/servicesRegister.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/authServiceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/serviceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/lazyResource.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/ingredient/compositeIngredient.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/cookbook.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/recipe.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';
import 'package:ricettario/studionotturno/cookbook/Level_3/user/userChecker.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/documentAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/Level_4/adapter/userJwtDataAdapter.dart';

void main() {


  Future<Map<String,String>> getHeader() async{
    //creazione dell'utente
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));
    //richiesta del token
    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    Object obj=UserJwtDataAdapter().setUser(u).toJson();
    Response response = await post("http://localhost:8080/user/public/login/",
        body: jsonEncode(<String,dynamic>{"data":obj}),
        encoding: Encoding.getByName("utf-8"));

    String token=response.headers.entries.firstWhere((element) => element.key=="token").value;
    print("token: "+token);

    //preparazione richiesta dell'header poi del body per la richiesta
    Map<String,String> header=new Map<String,String>();
    header.putIfAbsent("header", ()  => token);
    return header;
  }

  test("concrete iterator by name with empty set",()async{

    Map<String,String> header=await getHeader();//caricamento di un header con il token JWT
    //creo un json fake di ricette già ottenute da una precedente ricerca
    List<LazyResource> list=[];
    String name="spaghetti";
    Response response =await post(ServiceSpringboot().getUrl()+"/docu/iterator/byName/",
        headers: header,
        body: jsonEncode(
            <String,dynamic>{
              "res":list,
              "element":name
            }
        ));
    List<dynamic> json = jsonDecode(response.body);
    print(json.toString());
  });

  test("concrete iterator by name with full set",()async{
    caricaRicette2();
    //eliminazione di un po di ricette
    Cookbook().getRecipes().removeWhere((el)=>el.getName().contains("margherita"));

    //creo un json fake di ricette già attenute da una precedente ricerca
    List<LazyResource> list=[];
    Cookbook().getRecipes().forEach((recipe){
      //un json completo della ricetta
      Map<String,dynamic> json=DocumentAdapter().setUserName().setRecipe(recipe).toJson();
      //prendo solo alcuni componenti e faccio una lazyResource
      LazyResource l=new LazyResource().setRecipeName(json['recipeName'].toString());
      //riempio in json da inviare
      list.add(l);
    });
    Map<String,String> header=await getHeader();//caricamento di un header con il token JWT

    String name="pizza";
    Response response =await post(ServiceSpringboot().getUrl()+"/docu/iterator/byName/",
        headers: header,
        body: jsonEncode(
            <String,dynamic>{
              "res":list,
              "element":name
            }
        ));

    List<dynamic> json = jsonDecode(response.body);
    print(json.toString());

    /*List<dynamic> json = jsonDecode(response.body);
    List<LazyResource> lazyListResponse=new List<LazyResource>();
    json.forEach((doc){
      lazyListResponse.add(LazyResource().toObject(doc));
    });
    lazyListResponse.forEach((el)=>print(el.toString()));*/
  });

  test("GET all recipe",() async {
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));
    Response response = await get("http://localhost:8080/docu/get_documents/"+u.getEmail()+"/"+u.getPassword());
    List<dynamic> json = jsonDecode(response.body);
    List<Recipe> list=new List<Recipe>();
    json.forEach((doc){
      print(doc);
      list.add(DocumentAdapter().toObject((doc as Map<String,dynamic>)));
    });
  });

  test("test get all lazy recipe",() async {
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));

    Response response = await get("http://localhost:8080/docu/get_documents/"+u.getEmail()+"/"+u.getPassword());
    List<dynamic> json = jsonDecode(response.body);

    List<LazyResource> list=new List<LazyResource>();
    json.forEach((doc){
      list.add(new LazyResource()
          .setDocumentID(doc["_id"])
          .setRecipeName(doc['recipeName'].toString())
          .setExecutionTime(doc['executionTime']));
    });
    list.forEach((el)=>print(el.toString()));
  });

  test("GET single recipe",() async {
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));

    Response response = await get("http://localhost:8080/docu/get_documents/"+u.getEmail()+"/"+u.getPassword()+"/"+"pizza margherita");
    Map<String,dynamic> json = jsonDecode(response.body);
    Recipe r=DocumentAdapter().toObject(json);
    expect(r,isNotEmpty);

  });

  test("remove one recipe",() async{
    //creazione dell'utente
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));
    //richiesta del token
    ServicesRegister services=new ServicesRegister();
    AuthServiceSpringboot auth=services.getService("springboot").createServiceRegistration();
    Object obj=UserJwtDataAdapter().setUser(u).toJson();
    Response response = await post("http://localhost:8080/user/public/login/",
        body: jsonEncode(<String,dynamic>{"data":obj}),
        encoding: Encoding.getByName("utf-8"));

    String token=response.headers.entries.firstWhere((element) => element.key=="token").value;
    print("token: "+token);

    //preparazione richiesta dell'header poi del body per la richiesta
    Map<String,String> header=new Map<String,String>();
    header.putIfAbsent("header", ()  => token);

    Response responseDelete = await post("http://localhost:8080/docu/delete_documents/",
        body: jsonEncode(<String,dynamic>{"recipeName":"pizza margherita"}),
        encoding: Encoding.getByName("utf-8"),
        headers: header );

    print(responseDelete.headers.toString());
    print(responseDelete.body.toString());
  });


  test("retrieve documentid",() async{
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    checker.controlEmail(u.getEmail());
    u.setPassword(checker.criptPassword(u.getPassword()));
    Response response =await delete("http://localhost:8080/docu/recipes/"+u.getEmail()+"/"+u.getPassword()+"/"+"pizza margerita");

    print(response.body.toString());

  });


  test("post",() async {
    caricaRicette2();
    User u=new User();
    u.setEmail("marconeri@gmail.com");
    u.setPassword("marconeri");
    UserChecker checker=new UserChecker();
    u.setPassword(checker.criptPassword(u.getPassword()));
    Recipe r=Cookbook().getRecipe("pizza margherita");
    Map<String,dynamic> docu=DocumentAdapter().setUserName().setRecipe(r).toJson();

    Response response = await post("http://localhost:8080/docu/post_documents/", body: jsonEncode(docu));

    expect(await response.body.toString(), equals("true"));

  });


  test("client iterator by name",() async{
    List<LazyResource> list=[];//si inizia con la lista vuota
    ServiceSpringboot s=new ServiceSpringboot();
    await s.findRecipes(list, "trota", 0).then((el){
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    //altra ricerca
    expect(list.length, 1);
    list.forEach((el)=>print(el.toString()));
    //list.clear();
    await s.findRecipes(list, "spaghetti", 0).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 0);
    print("**************");
    list.forEach((el)=>print(el.toString()));
  });

  test("client iterator ingredient",() async{
    List<LazyResource> list=[];//si inizia con la lista vuota
    ServiceSpringboot s=new ServiceSpringboot();
    await s.findRecipes(list, "banana", 1).then((el){
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    //altra ricerca
    //expect(list.length, 2);
    list.forEach((el)=>print(el.toString()));

    await s.findRecipes(list, "cipolla", 1).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 2);
    print("**************");
    list.forEach((el)=>print(el.toString()));

    await s.findRecipes(list, "aglio", 1).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 1);
    print("**************");
    list.forEach((el)=>print(el.toString()));
  });

  test("client iterator ingredient2",() async{
    List<LazyResource> list=[];//si inizia con la lista vuota
    ServiceSpringboot s=new ServiceSpringboot();

    await s.findRecipes(list, "aglio", 1).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 2);
    print("**************");
    list.forEach((el)=>print(el.toString()));

    await s.findRecipes(list, "cipolla", 1).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 1);
    print("**************");
    list.forEach((el)=>print(el.toString()));
  });

  test("client iterator name then time then ingredient",() async{
    List<LazyResource> list=[];//si inizia con la lista vuota
    ServiceSpringboot s=new ServiceSpringboot();

    await s.findRecipes(list, "pizza", 0).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 5);
    print("**************");
    list.forEach((el)=>print(el.toString()));

    await s.findRecipes(list, 30.toString(), 2).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 3);
    print("**************");
    list.forEach((el)=>print(el.toString()));

    await s.findRecipes(list, "peperoncino", 1).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });
    expect(list.length, 1);
    print("**************");
    list.forEach((el)=>print(el.toString()));
  });

  test("totale",() async {
    //TODO non è finito
    List<LazyResource> list=[];//si inizia con la lista vuota
    ServiceSpringboot s=new ServiceSpringboot();
    //la struttura dati per i tag da inviare al backend
    Map<String,List<String>> totalTags=new Map<String,List<String>>();
    List<String> listOfName= new List<String>();
    List<String> listOfIngredient= new List<String>();
    List<String> listOfTime= new List<String>();
    //inserimento dei tag
    listOfName.add("\"spaghetti\"");
    listOfName.add("\"scoglio\"");
    listOfIngredient.add("\"banana\"");
    //listOfIngredient.add("\"alici2\"");
    //listOfTime.add("\"30\"");
    //listOfTime.add("\"600\"");
    totalTags.putIfAbsent("\"name\"", ()=>listOfName);
    totalTags.putIfAbsent("\"ing\"", ()=>listOfIngredient);
    totalTags.putIfAbsent("\"time\"", ()=>listOfTime);

    //invio della richesta al backend
    await s.findRecipes(list, totalTags.toString(), 4).then((el){
      list.clear();
      el.forEach((lazy)=>list.add(lazy));//la lista viene riempita con i risultati del backend
    });

  });
}

void caricaRicette2() {
  print("caricamento ricette");
  Cookbook cookBook=new Cookbook();
  cookBook.clear();

  cookBook.addRecipe("spachetti allo scoglio");
  cookBook.getRecipe("spachetti allo scoglio").setDifficult(1);
  cookBook.getRecipe("spachetti allo scoglio").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
  cookBook.getRecipe("spachetti allo scoglio").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("spachetti allo scoglio").addComposite("sugo", 100, "gr");
  CompositeIngredient d7=cookBook.getRecipe("spachetti allo scoglio").getIngredient("sugo");
  d7.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("spachetti allo scoglio").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient d8=cookBook.getRecipe("spachetti allo scoglio").getIngredient("impasto per pizza");
  d8.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  cookBook.getRecipe("spachetti allo scoglio").addSimple("banana", 2, "pz");


  cookBook.addRecipe("trota");
  cookBook.getRecipe("trota").setDifficult(3);
  cookBook.getRecipe("trota").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
  cookBook.getRecipe("trota").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("trota").addComposite("sugo", 100, "gr");
  CompositeIngredient d5=cookBook.getRecipe("trota").getIngredient("sugo");
  d5.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("trota").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient d6=cookBook.getRecipe("trota").getIngredient("impasto per pizza");
  d6.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  cookBook.getRecipe("trota").addSimple("banana", 2, "pz");


  cookBook.addRecipe("torciglioni alla carbonara");
  cookBook.getRecipe("torciglioni alla carbonara").setDifficult(3);
  cookBook.getRecipe("torciglioni alla carbonara").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
  cookBook.getRecipe("torciglioni alla carbonara").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("torciglioni alla carbonara").addComposite("sugo", 100, "gr");
  CompositeIngredient d3=cookBook.getRecipe("torciglioni alla carbonara").getIngredient("sugo");
  d3.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("torciglioni alla carbonara").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient d4=cookBook.getRecipe("torciglioni alla carbonara").getIngredient("impasto per pizza");
  d4.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  cookBook.getRecipe("torciglioni alla carbonara").addSimple("banana", 2, "pz");


  cookBook.addRecipe("spaghetti alla carbonara");
  cookBook.getRecipe("spaghetti alla carbonara").setDifficult(3);
  cookBook.getRecipe("spaghetti alla carbonara").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
  cookBook.getRecipe("spaghetti alla carbonara").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("spaghetti alla carbonara").addComposite("sugo", 100, "gr");
  CompositeIngredient d1=cookBook.getRecipe("spaghetti alla carbonara").getIngredient("sugo");
  d1.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("spaghetti alla carbonara").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient d2=cookBook.getRecipe("spaghetti alla carbonara").getIngredient("impasto per pizza");
  d2.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  cookBook.getRecipe("spaghetti alla carbonara").addSimple("banana", 2, "pz");

  cookBook.addRecipe("pizza margherita");
  cookBook.getRecipe("pizza margherita").setDifficult(3);
  cookBook.getRecipe("pizza margherita").setDescription("una descrizione molto bella e molto lunga per far vedere che c'p una descrizione interssante e molto avvincente perchè a noi piace programmare");
  cookBook.getRecipe("pizza margherita").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita").addComposite("sugo", 100, "gr");
  CompositeIngredient c1=cookBook.getRecipe("pizza margherita").getIngredient("sugo");
  c1.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c2=cookBook.getRecipe("pizza margherita").getIngredient("impasto per pizza");
  c2.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  cookBook.getRecipe("pizza margherita").addSimple("banana", 2, "pz");


  //nuova ricetta2
  cookBook.addRecipe("pizza marinara");
  cookBook.getRecipe("pizza marinara").setDifficult(3);
  cookBook.getRecipe("pizza marinara").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara").addComposite("sugo", 100, "gr");
  CompositeIngredient c3=cookBook.getRecipe("pizza marinara").getIngredient("sugo");
  c3.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c4=cookBook.getRecipe("pizza marinara").getIngredient("impasto per pizza");
  c4.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta3
  cookBook.addRecipe("pizza margherita1");
  cookBook.getRecipe("pizza margherita1").setDifficult(4);
  cookBook.getRecipe("pizza margherita1").setExecutionTime(new ExecutionTime(1,0));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita1").addComposite("sugo", 100, "gr");
  CompositeIngredient c5=cookBook.getRecipe("pizza margherita1").getIngredient("sugo");
  c5.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita1").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c6=cookBook.getRecipe("pizza margherita1").getIngredient("impasto per pizza");
  c6.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta4
  cookBook.addRecipe("pizza margherita2");
  cookBook.getRecipe("pizza margherita2").setDifficult(3);
  cookBook.getRecipe("pizza margherita2").setExecutionTime(new ExecutionTime(1,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza margherita2").addComposite("sugo", 100, "gr");
  CompositeIngredient c7=cookBook.getRecipe("pizza margherita2").getIngredient("sugo");
  c7.addByParameter("salsa di pomodoro2", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza margherita2").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c8=cookBook.getRecipe("pizza margherita2").getIngredient("impasto per pizza");
  c8.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta5
  cookBook.addRecipe("pizza marinara1");
  cookBook.getRecipe("pizza marinara1").setDifficult(3);
  cookBook.getRecipe("pizza marinara1").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara1").addComposite("sugo", 100, "gr");
  CompositeIngredient c9=cookBook.getRecipe("pizza marinara1").getIngredient("sugo");
  c9.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr")
      .addByParameter("alici", 20, "pz");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara1").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c10=cookBook.getRecipe("pizza marinara1").getIngredient("impasto per pizza");
  c10.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta6
  cookBook.addRecipe("pizza marinara2");
  cookBook.getRecipe("pizza marinara2").setDifficult(3);
  cookBook.getRecipe("pizza marinara2").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara2").addComposite("sugo", 100, "gr");
  CompositeIngredient c11=cookBook.getRecipe("pizza marinara2").getIngredient("sugo");
  c11.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara2").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c12=cookBook.getRecipe("pizza marinara2").getIngredient("impasto per pizza");
  c12.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

  //nuova ricetta7
  cookBook.addRecipe("pizza marinara3");
  cookBook.getRecipe("pizza marinara3").setDifficult(3);
  cookBook.getRecipe("pizza marinara3").setExecutionTime(new ExecutionTime(0,30));
  //aggiunta di una ingrediente composto
  cookBook.getRecipe("pizza marinara3").addComposite("sugo", 100, "gr");
  CompositeIngredient c13=cookBook.getRecipe("pizza marinara3").getIngredient("sugo");
  c13.addByParameter("salsa di pomodoro", 1, "l")
      .addByParameter("sale", 0, "gr");
  //aggiunta di un secondo ingrediente composto
  cookBook.getRecipe("pizza marinara3").addComposite("impasto per pizza", 1, "kg");
  CompositeIngredient c14=cookBook.getRecipe("pizza marinara3").getIngredient("impasto per pizza");
  c14.addByParameter("farina 00", 200, "gr")
      .addByParameter("sale", 10, "gr")
      .addByParameter("olio", 35, "gr")
      .addByParameter("lievito di birra", 5, "gr");

}