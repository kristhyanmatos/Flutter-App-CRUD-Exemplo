import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../../domain/errors/failure.dart';
import '../../infra/datasources/criptografia_datasource.dart';

class CriptografiaDataSource implements ICriptografiaDataSource {
  @override
  Future<String> codificarSHA256(String valor) async {
    try {
      final secretKey = dotenv.get("secretKey");
      final key = utf8.encode(secretKey);
      final bytes = utf8.encode(valor);
      var hmacSha256 = Hmac(sha256, key);
      final digest = hmacSha256.convert(bytes);
      return digest.toString();
    } catch (exception, stackTrace) {
      throw Failure(
        exception.toString(),
        exception: exception,
        stackTrace: stackTrace,
        label: "CriptografiaService-codificar",
      );
    }
  }
}
