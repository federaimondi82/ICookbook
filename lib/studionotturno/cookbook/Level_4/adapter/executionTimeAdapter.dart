

import 'package:ricettario/studionotturno/cookbook/Level_3/recipe/executionTime.dart';

import 'target.dart';

class ExecutionTimeAdapter extends Target{

  ExecutionTime exec;

  ExecutionTimeAdapter(){
    this.exec=new ExecutionTime(0,0);
  }

  ExecutionTimeAdapter setTime(ExecutionTime time){
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
  ExecutionTime toObject(dynamic data) {
    //print(data);
    this.exec.setMinutes(data);
    return this.exec.toTime();
    return null;
    this.exec.houres = data['HH'];
    this.exec.minutes= data['MM'];
    return this.exec;
  }


}