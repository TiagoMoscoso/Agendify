import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

String Converter(String inputString){

  //Pega os bytes
  Uint8List bytes = Uint8List.fromList(utf8.encode(inputString));

  // Calcula o hash dos bytes
  Digest md5Digest = md5.convert(bytes);

  // Converte hash para md5
  String md5Hash = md5Digest.toString();

  return md5Hash;
}