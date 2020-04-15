


import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/imageManagerFirebase.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/recipeMapperFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/firebase/serviceFirestore.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/imageManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/authService.dart';

import '../abstractService.dart';
import 'authServiceFirebase.dart';


///Tutti quei servizi legati a Firebase; fa parte del design pattern Abstract factory
class ConcreteProductFirebase implements AbstractService{

  @override
  ImageManager createImageManager() {
    return new ImageManagerFirebase();
  }

  @override
  RecipeMapper createMapper() {
    return new RecipeMapperFirestore();
  }

  @override
  ServiceCloud createServiceCloud() {
    return new ServiceFirestore();
  }

  @override
  AuthService createServiceRegistration() {
    return new AuthServiceFirebase();
  }

}