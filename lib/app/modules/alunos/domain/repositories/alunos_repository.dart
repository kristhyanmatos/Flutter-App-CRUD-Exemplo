import 'package:dartz/dartz.dart';

import '../entities/aluno.dart';
import '../../../core/domain/errors/failure.dart';

abstract class IAlunosRepository {
  Future<Either<Failure, void>> cadastrar(Aluno aluno);
  Future<Either<Failure, List<Aluno>>> buscarTodos();
  Future<Either<Failure, void>> atualizar(Aluno aluno);
  Future<Either<Failure, void>> atualizarStatus(String alunoId, bool isAtivo);
}
