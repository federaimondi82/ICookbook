
import 'abstractService.dart';
import 'firebase/concreteProductFirebase.dart';
import 'springboot/concreteProductSpringboot.dart';

///Questo register permette di memorizzare tutti gli AbstractService implementati
///nell'applicazione.<br>
///Ogni utente, in fase di registrazione deve scegliere quale servizio utilizzare;
/// i servizi offrono funzionalità simili ma a costi e performance differenti.<br><br>

///Questa classe è un singleton e Facede; singleton perchè vi è una sola istanza presente
/// a runtime, facede perchè è l'unico punto di accesso dall'esterno del pacchetto AbstractServies
class ServicesRegister{

  static final ServicesRegister _servicesRegister=ServicesRegister._internal();
  static Map<String,AbstractService> register;
  ServicesRegister._internal();

  factory ServicesRegister(){
    if(register==null){
      register=new Map<String,AbstractService>();
      register.putIfAbsent("firebase", ()=>new ConcreteProductFirebase());
      register.putIfAbsent("springboot", ()=>new ConcreteProductSpringboot());
    }
    return _servicesRegister;
  }

  AbstractService getService(String name){
    return register.putIfAbsent(name, () => null);
  }

  Map<String,AbstractService> getServices(){
    return register;
  }



}