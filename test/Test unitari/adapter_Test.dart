

import 'package:flutter_test/flutter_test.dart';
import 'package:ricettario/studionotturno/cookbook/foundation/cookbookLoader.dart';

void main() {


  test("read .txt file",(){

    CookbookLoader loader=new CookbookLoader();
    loader.read();

  });

}
