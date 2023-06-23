import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OpcoesDeslizeWidget extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final Function acao;
  final Widget child;
  const OpcoesDeslizeWidget({
    super.key,
    required this.titulo,
    required this.mensagem,
    required this.acao,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            label: titulo,
            onPressed: (context) async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(titulo),
                    content: Text(mensagem),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancelar"),
                      ),
                      FilledButton(
                        onPressed: () => {acao(), Navigator.of(context).pop()},
                        child: const Text("Confirmar"),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ],
      ),
      child: child,
    );
  }
}
