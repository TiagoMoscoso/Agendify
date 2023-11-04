import "../Crypto/Crypto.dart";

Map<String, dynamic> UserPasswordToJson(int id, String password) {
  password = Converter(password);
  return {
    id.toString():
    {
    'Password': password,
    }
  };
}
