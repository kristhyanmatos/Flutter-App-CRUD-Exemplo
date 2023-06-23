import 'package:dartz/dartz.dart';
import '../../domain/entities/aluno.dart';
import '../../../core/domain/errors/failure.dart';
import '../../domain/repositories/alunos_repository.dart';
import '../datasources/alunos_datasource.dart';

class AlunosRepository implements IAlunosRepository {
  final IAlunosDataSource _dataSource;

  AlunosRepository(this._dataSource);

  @override
  Future<Either<Failure, void>> cadastrar(Aluno aluno) async {
    try {
      await _dataSource.cadastar(aluno.toMap());
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stackTrace) {
      return Left(
        FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosRepository-cadastrar",
          exception: exception,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> atualizar(Aluno aluno) async {
    try {
      final map = aluno.toMap();
      map.remove("id");
      map.remove("senha");
      await _dataSource.atualizar(aluno.id ?? "", map);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stackTrace) {
      return Left(
        FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosRepository-atualizar",
          exception: exception,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> atualizarStatus(
    String alunoId,
    bool isAtivo,
  ) async {
    try {
      await _dataSource.atualizarStatus(alunoId, isAtivo);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stackTrace) {
      return Left(
        FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosRepository-atualizarStatus",
          exception: exception,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Aluno>>> buscarTodos() async {
    try {
      final response = await _dataSource.buscarTodos();
      List<Aluno> alunos = response
          .map(
            (aluno) => Aluno.fromMap(aluno),
          )
          .toList();
      return Right(alunos);
    } on Failure catch (e) {
      return Left(e);
    } catch (exception, stackTrace) {
      return Left(
        FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosRepository-buscarTodos",
          exception: exception,
        ),
      );
    }
  }
}
