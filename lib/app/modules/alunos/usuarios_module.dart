import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/alunos_repository.dart';
import 'domain/usecases/atualizar_aluno.dart';
import 'domain/usecases/atualizar_status_aluno.dart';
import 'domain/usecases/buscar_todos_alunos.dart';
import 'domain/usecases/cadastrar_aluno.dart';
import 'external/datasources/alunos_datasource.dart';
import 'infra/datasources/alunos_datasource.dart';
import 'infra/repositories/alunos_repository.dart';
import 'presenter/pages/aluno_page.dart';
import 'presenter/pages/alunos_page.dart';
import 'presenter/stores/aluno_store.dart';
import 'presenter/stores/alunos_store.dart';

class AlunosModule extends Module {
  @override
  final List<Bind> binds = [
    // external
    Bind((i) => FirebaseFirestore.instance),
    Bind.singleton<IAlunosDataSource>((i) => AlunosDataSource(i())),
    // infra
    Bind.singleton<IAlunosRepository>((i) => AlunosRepository(i())),
    // domain
    Bind.factory<IUCCadastrarAluno>((i) => UCCadastrarAluno(i(), i())),
    Bind.factory<IUCBuscarTodosAlunos>((i) => UCBuscarTodosAlunos(i())),
    Bind.factory<IUCAtualizarAluno>((i) => UCAtualizarAluno(i())),
    Bind.factory<IUCAtualizarStatusAluno>((i) => UCAtualizarStatusAluno(i())),
    // presenter
    Bind.singleton((i) => AlunosStore(i(), i())),
    Bind.factory((i) => AlunoStore(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const AlunosPage(),
    ),
    ChildRoute(
      "/aluno",
      child: (context, args) => AlunoPage(aluno: args.data),
    )
  ];
}
