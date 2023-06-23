import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VazioWidget extends StatelessWidget {
  final String mensagem;
  const VazioWidget({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/vazio.svg",
            width: MediaQuery.of(context).size.width * 0.2,
            semanticsLabel: 'Vazio',
          ),
          const SizedBox(height: 24),
          Text(mensagem, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
