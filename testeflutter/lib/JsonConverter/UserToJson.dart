import 'package:testeflutter/Classes/ClassUser.dart';

Map<String, dynamic> UserToJson(ClassUser user) {
  return {
    'name': user.getName(),
    'telephone': user.getTelephone(),
    'email': user.getEmail(),
    'photo': user.getPhoto(),
  };
}
