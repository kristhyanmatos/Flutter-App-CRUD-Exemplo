import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/aluno.dart';
import '../../domain/usecases/atualizar_status_aluno.dart';
import '../../domain/usecases/buscar_todos_alunos.dart';
import '../utils/snackbar_show.dart';

class AlunosStore extends Store<List<Aluno>> {
  final IUCBuscarTodosAlunos _buscarTodosAlunos;
  final IUCAtualizarStatusAluno _atualizarStatusAluno;

  AlunosStore(this._buscarTodosAlunos, this._atualizarStatusAluno) : super([]);

  Future<void> buscarTodosAlunos() async {
    setLoading(true);
    final response = await _buscarTodosAlunos();
    response.fold(
      (l) => {showSnackBar(l.message), update(state, force: true)},
      (r) => update(r),
    );
    setLoading(false);
  }

  Future<void> atualizarStatusAluno(String alunoId, bool isAtivo) async {
    setLoading(true);
    final response = await _atualizarStatusAluno(alunoId, isAtivo);
    response.fold(
      (l) => {showSnackBar(l.message), update(state, force: true)},
      (r) => buscarTodosAlunos(),
    );
    setLoading(false);
  }
}
