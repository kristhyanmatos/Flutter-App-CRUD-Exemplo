import 'package:dartz/dartz.dart';

import '../entities/aluno.dart';
import '../../../core/domain/errors/failure.dart';
import '../repositories/alunos_repository.dart';

abstract class IUCAtualizarAluno {
  Future<Either<Failure, void>> call(Aluno aluno);
}

class UCAtualizarAluno implements IUCAtualizarAluno {
  final IAlunosRepository _repository;

  UCAtualizarAluno(this._repository);

  @override
  Future<Either<Failure, void>> call(Aluno aluno) async {
    return await _repository.atualizar(aluno);
  }
}
