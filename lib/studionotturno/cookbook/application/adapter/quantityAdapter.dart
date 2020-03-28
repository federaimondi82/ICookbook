
import 'package:ricettario/studionotturno/cookbook/domain/ingredient/quantity.dart';
import 'unitAdapter.dart';
import 'target.dart';

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
  Quantity toObject(Map<dynamic, dynamic> data) {
    this.quantity.amount = data['amount'];
    this.quantity.unit=UnitAdapter().toObject(data['unit']);
    return this.quantity;
  }
  
  
}