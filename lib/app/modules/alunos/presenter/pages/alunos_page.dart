import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/entities/aluno.dart';
import '../stores/alunos_store.dart';
import '../widgets/opcoes_deslize_widget.dart';
import '../widgets/vazio_widget.dart';

class AlunosPage extends StatefulWidget {
  const AlunosPage({super.key});

  @override
  State<AlunosPage> createState() => _AlunosPageState();
}

class _AlunosPageState extends State<AlunosPage> {
  final AlunosStore store = Modular.get<AlunosStore>();
  bool isAtivos = true;

  @override
  void initState() {
    store.buscarTodosAlunos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Alunos"),
          bottom: TabBar(
            onTap: (value) {
              if (value == 0) {
                isAtivos = true;
              } else {
                isAtivos = false;
              }
              setState(() {});
            },
            tabs: const [Tab(text: "Ativos"), Tab(text: "Inativos")],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: store.buscarTodosAlunos,
          child: ScopedBuilder<AlunosStore, List<Aluno>>(
            store: store,
            onLoading: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            onState: (context, state) {
              final alunos = state.where((aluno) => aluno.isAtivo == isAtivos);
              if (alunos.isEmpty) {
                return const VazioWidget(mensagem: 'A lista está vazia');
              } else {
                return ListView(
                  children: alunos.map((aluno) {
                    final mensagem =
                        "Desenha ${isAtivos ? "Inativar" : "Ativar"} o aluno ${aluno.nome}";
                    return OpcoesDeslizeWidget(
                      titulo: isAtivos ? "Inativar" : "Ativar",
                      mensagem: mensagem,
                      acao: () => store.atualizarStatusAluno(
                        aluno.id ?? "",
                        !isAtivos,
                      ),
                      child: ListTile(
                        title: Text(
                          aluno.nome,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          aluno.observacao,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(Icons.arrow_forward, size: 14),
                        onTap: () => Modular.to.pushNamed(
                          "/aluno",
                          arguments: aluno,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Modular.to.pushNamed("/aluno"),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
