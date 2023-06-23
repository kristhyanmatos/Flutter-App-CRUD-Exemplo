import 'package:dartz/dartz.dart';

import 'package:ps_davos_tech/app/modules/core/domain/errors/failure.dart';

import '../../domain/services/criptografia_service.dart';
import '../datasources/criptografia_datasource.dart';

class CriptografiaService implements ICriptografiaService {
  final ICriptografiaDataSource _dataSource;

  CriptografiaService(this._dataSource);

  @override
  Future<Either<Failure, String>> codificarSHA256(String valor) async {
    try {
      final response = await _dataSource.codificarSHA256(valor);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stackTrace) {
      return Left(
        FailureUnknow(
          stackTrace: stackTrace,
          label: "CriptografiaService-codificarSHA256",
          exception: exception,
        ),
      );
    }
  }
}
