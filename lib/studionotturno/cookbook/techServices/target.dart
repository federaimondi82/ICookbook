
import 'dart:collection';

///Interfaccia che definisce le operazioni per adattare gli oggetti in locale con quelli in cloud.
///E' una classe del desing pattern Adapter
///
/// Per ogni classe che farà parte di una ricetta ci sarà un Adapter che adatta i
/// dati tra client e server e viceversa
abstract class Target{

  ///Trasforma un oggetto in dati in formato json
  Map<String,dynamic> toJson();

  ///Trasforma dei dati in formato json in una istanza della busoness Logic
  Object toObject(Map<dynamic, dynamic> data);

}