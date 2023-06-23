import 'package:dartz/dartz.dart';
import 'package:ps_davos_tech/app/modules/core/domain/errors/failure.dart';
import 'package:ps_davos_tech/app/modules/core/domain/services/criptografia_service.dart';

import '../entities/aluno.dart';
import '../repositories/alunos_repository.dart';

abstract class IUCCadastrarAluno {
  Future<Either<Failure, void>> call(Aluno aluno);
}

class UCCadastrarAluno implements IUCCadastrarAluno {
  final IAlunosRepository _alunosRepository;
  final ICriptografiaService _criptografiaService;

  UCCadastrarAluno(this._alunosRepository, this._criptografiaService);

  @override
  Future<Either<Failure, void>> call(Aluno aluno) async {
    final response = await _criptografiaService.codificarSHA256(aluno.senha);
    return await response.fold(
      (l) async => Left(l),
      (senhaSHA256) async {
        // final alunoJson = aluno
        // final alunoSHA256 = Aluno.fromMap(alu)
        aluno.setSenha(senhaSHA256);
        return await _alunosRepository.cadastrar(aluno);
      },
    );
  }
}
