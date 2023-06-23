import 'package:dartz/dartz.dart';
import '../entities/aluno.dart';
import '../../../core/domain/errors/failure.dart';
import '../repositories/alunos_repository.dart';

abstract class IUCBuscarTodosAlunos {
  Future<Either<Failure, List<Aluno>>> call();
}

class UCBuscarTodosAlunos implements IUCBuscarTodosAlunos {
  final IAlunosRepository _repository;

  UCBuscarTodosAlunos(this._repository);

  @override
  Future<Either<Failure, List<Aluno>>> call() async {
    return await _repository.buscarTodos();
  }
}
