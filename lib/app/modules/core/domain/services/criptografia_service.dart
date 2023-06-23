import 'package:dartz/dartz.dart';
import 'package:ps_davos_tech/app/modules/core/domain/errors/failure.dart';

abstract class ICriptografiaService {
  Future<Either<Failure, String>> codificarSHA256(String valor);
}
