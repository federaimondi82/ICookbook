

import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/authService.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/imageManager.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/recipeMapper.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/serviceCloud.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/authServiceSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/imageManagerSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/recipeMapperSpringboot.dart';
import 'package:ricettario/studionotturno/cookbook/Level_1/abstractServices/springboot/serviceSpringboot.dart';

import '../abstractService.dart';

class ConcreteProductSpringboot implements AbstractService{
  @override
  ImageManager createImageManager() {
    return new ImageManagerSpringboot();
  }

  @override
  RecipeMapper createMapper() {
    return new RecipeMapperSpringboot();
  }

  @override
  ServiceCloud createServiceCloud() {
    return new ServiceSpringboot();
  }

  @override
  AuthService createServiceRegistration() {
    return new AuthServiceSpringboot();
  }

}