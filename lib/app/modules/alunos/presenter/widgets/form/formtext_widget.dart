import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextWidget extends StatefulWidget {
  final String? titulo;
  final String? valor;
  final Function(String)? onChanged;
  final bool isTextoObscuro;
  final bool isHabilitado;
  final TextAlign alinhamentoTexto;
  final TextInputType tipoTeclado;
  final List<TextInputFormatter> mascaras;
  final String? Function(String?)? validador;
  final int numeroLinhas;
  const FormTextWidget({
    Key? key,
    this.titulo,
    this.valor,
    this.onChanged,
    this.alinhamentoTexto = TextAlign.left,
    this.isHabilitado = true,
    this.isTextoObscuro = false,
    this.tipoTeclado = TextInputType.text,
    this.mascaras = const [],
    this.validador,
    this.numeroLinhas = 1,
  }) : super(key: key);

  @override
  State<FormTextWidget> createState() => _FormTextWidgetState();
}

class _FormTextWidgetState extends State<FormTextWidget> {
  bool isMostrarTexto = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        initialValue: widget.valor,
        textAlign: widget.alinhamentoTexto,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validador,
        keyboardType: widget.tipoTeclado,
        inputFormatters: widget.mascaras.isNotEmpty ? widget.mascaras : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.titulo,
          suffixIcon: widget.isTextoObscuro
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isMostrarTexto = !isMostrarTexto;
                    });
                  },
                  child: Icon(
                    isMostrarTexto ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
        ),
        obscureText: widget.isTextoObscuro && !isMostrarTexto,
        onChanged: widget.onChanged,
        enabled: widget.isHabilitado,
        maxLines: widget.numeroLinhas,
      ),
    );
  }
}
