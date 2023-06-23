import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:validadores/validadores.dart';

import '../../extensions/string.dart';
import '../../domain/entities/aluno.dart';
import '../stores/aluno_store.dart';
import '../widgets/form/formtext_widget.dart';

class AlunoPage extends StatefulWidget {
  final Aluno? aluno;
  const AlunoPage({super.key, required this.aluno});

  @override
  State<AlunoPage> createState() => _AlunoPageState();
}

class _AlunoPageState extends State<AlunoPage> {
  final AlunoStore store = Modular.get<AlunoStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    store.initAluno(widget.aluno);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    store.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aluno")),
      body: ScopedBuilder<AlunoStore, Aluno>(
        store: store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) => Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 12),
              FormTextWidget(
                titulo: "Nome",
                valor: state.nome,
                onChanged: (value) => state.setNome(value),
                validador: (value) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Nome obrigatório')
                      .minLength(5, msg: "Mínimo 5 caracteres")
                      .valido(value)
                      ?.formatarErrorFormText();
                },
              ),
              const SizedBox(height: 12),
              FormTextWidget(
                titulo: "Telefone",
                valor: state.telefone,
                onChanged: (value) => state.setTelefone(value),
                tipoTeclado: TextInputType.phone,
                mascaras: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                validador: (value) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Telefone obrigatório')
                      .minLength(14)
                      .maxLength(15)
                      .valido(value)
                      ?.formatarErrorFormText();
                },
              ),
              const SizedBox(height: 12),
              FormTextWidget(
                titulo: "E-mail",
                valor: state.email,
                onChanged: (value) => state.setEmail(value),
                tipoTeclado: TextInputType.emailAddress,
                validador: (value) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'E-mail obrigatório')
                      .add(Validar.EMAIL, msg: 'E-mail inválido')
                      .valido(value)
                      ?.formatarErrorFormText();
                },
              ),
              const SizedBox(height: 12),
              if (widget.aluno == null)
                FormTextWidget(
                  titulo: "Senha",
                  valor: state.senha,
                  onChanged: (value) => {state.setSenha(value)},
                  tipoTeclado: TextInputType.visiblePassword,
                  isTextoObscuro: true,
                  validador: (value) {
                    if (widget.aluno == null) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: 'Senha obrigatória')
                          .minLength(12,
                              msg:
                                  "Senha inválida! Deve conter entre 12 à 24 caracteres.")
                          .maxLength(24,
                              msg:
                                  "Senha inválida! Deve conter entre 12 à 24 caracteres.")
                          .valido(value)
                          ?.formatarErrorFormText();
                    } else {
                      return null;
                    }
                  },
                ),
              const SizedBox(height: 12),
              FormTextWidget(
                titulo: "Valor Mensalidade",
                valor: UtilBrasilFields.obterReal(
                  state.valorMensalidade.toDouble(),
                  moeda: true,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final moeda = UtilBrasilFields.converterMoedaParaDouble(
                      value,
                    );
                    state.setMensalidade(moeda);
                  }
                },
                tipoTeclado: TextInputType.number,
                mascaras: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true),
                ],
                validador: (value) {
                  if (value?.isNotEmpty ?? false) {
                    final moeda = UtilBrasilFields.converterMoedaParaDouble(
                      value!,
                    );
                    return Validador()
                        .minVal(1)
                        .valido(moeda.toInt().toString())
                        ?.formatarErrorFormText();
                  } else {
                    return Validador()
                        .add(Validar.OBRIGATORIO,
                            msg: 'Mensalidade obrigatória')
                        .valido(value.toString())
                        ?.formatarErrorFormText();
                  }
                },
              ),
              const SizedBox(height: 12),
              FormTextWidget(
                titulo: "Observação",
                valor: state.observacao,
                onChanged: (value) => state.setObservacao(value),
                numeroLinhas: 4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          if (widget.aluno == null) {
            store.cadastrarAluno();
          } else {
            store.atualizarAluno();
          }
        },
        label: const Text("Salvar"),
      ),
    );
  }
}
