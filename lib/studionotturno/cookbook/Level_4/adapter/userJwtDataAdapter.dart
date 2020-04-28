
import 'package:ricettario/studionotturno/cookbook/Level_3/user/user.dart';

class UserJwtDataAdapter {

  User user;

  UserJwtDataAdapter();

  UserJwtDataAdapter setUser(User user){
    this.user=user;
    return this;
  }

   @override
   Map<String, dynamic> toJson() {
     return {
       "email": this.user.getEmail()==null?"":this.user.getEmail(),
       "password":this.user.getPassword()==null?"":this.user.getPassword(),
     };
   }

}