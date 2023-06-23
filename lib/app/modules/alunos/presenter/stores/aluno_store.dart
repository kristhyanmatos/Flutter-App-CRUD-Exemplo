import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../domain/entities/aluno.dart';
import '../../domain/usecases/atualizar_aluno.dart';
import '../../domain/usecases/cadastrar_aluno.dart';
import '../utils/snackbar_show.dart';
import 'alunos_store.dart';

class AlunoStore extends Store<Aluno> {
  final IUCCadastrarAluno _cadastrarAluno;
  final IUCAtualizarAluno _atualizarAluno;
  final AlunosStore _alunosStore;
  AlunoStore(
    this._cadastrarAluno,
    this._alunosStore,
    this._atualizarAluno,
  ) : super(Aluno.init());

  void initAluno(Aluno? aluno) {
    if (aluno != null) {
      update(aluno);
    }
  }

  Future<void> cadastrarAluno() async {
    setLoading(true);
    final response = await _cadastrarAluno(state);
    response.fold(
      (l) => {showSnackBar(l.message), update(state, force: true)},
      (r) => {
        _alunosStore.buscarTodosAlunos(),
        Modular.to.pop(),
      },
    );
    setLoading(false);
  }

  Future<void> atualizarAluno() async {
    setLoading(true);
    final response = await _atualizarAluno(state);
    response.fold(
      (l) => {showSnackBar(l.message), update(state, force: true)},
      (r) => {
        _alunosStore.buscarTodosAlunos(),
        Modular.to.pop(),
      },
    );
    setLoading(false);
  }
}
