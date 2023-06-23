import 'package:dartz/dartz.dart';
import 'package:ps_davos_tech/app/modules/core/domain/errors/failure.dart';

import '../repositories/alunos_repository.dart';

abstract class IUCAtualizarStatusAluno {
  Future<Either<Failure, void>> call(String alunoId, bool isAtivo);
}

class UCAtualizarStatusAluno implements IUCAtualizarStatusAluno {
  final IAlunosRepository _repository;

  UCAtualizarStatusAluno(this._repository);

  @override
  Future<Either<Failure, void>> call(String alunoId, bool isAtivo) async {
    return await _repository.atualizarStatus(alunoId, isAtivo);
  }
}
