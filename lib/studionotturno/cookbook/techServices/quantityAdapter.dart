
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/unitAdapter.dart';
import 'package:ricettario/studionotturno/cookbook/techServices/target.dart';

class QuantityAdapter extends Target{
  
  Quantity quantity;
  
  QuantityAdapter(){
    this.quantity=new Quantity();
  }

  QuantityAdapter setQuantity(Quantity quantity){
    this.quantity=quantity;
    return this;
  }

  @override
  Map<String,dynamic> toJson() {
    return {
      "amount": this.quantity.amount,
      "unit": UnitAdapter().setUnit(this.quantity.unit).toJson()
    };
  }

  @override
  Quantity toObject(Map<String,dynamic> data) {
    this.quantity.amount = data['amount'];
    this.quantity.unit=UnitAdapter().toObject(data['unit']);
    //this.quantity.unit=data['unit'];
    return this.quantity;
  }
  
  
}