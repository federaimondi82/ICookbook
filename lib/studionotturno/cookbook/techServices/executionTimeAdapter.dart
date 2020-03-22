
import 'dart:collection';

import 'package:ricettario/studionotturno/cookbook/domain/recipe/executionTime.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/target.dart';

class ExecutionTimeAdapter extends Target{

  ExecutionTime exec;

  ExecutionTimeAdapter(){
    this.exec=new ExecutionTime(0,0);
  }

  ExecutionTimeAdapter setTime(ExecutionTime time){
    //TODO
    this.exec=time;
    return this;
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      "HH": this.exec.houres,
      "MM": this.exec.minutes
    };
  }

  @override
  ExecutionTime toObject(Map<dynamic, dynamic> data) {
    this.exec.houres = data['HH'];
    this.exec.minutes= data['MM'];
    return this.exec;
  }


}