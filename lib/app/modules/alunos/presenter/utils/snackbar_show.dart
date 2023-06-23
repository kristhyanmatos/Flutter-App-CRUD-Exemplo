import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

void showSnackBar(String mensagem) {
  Asuka.showSnackBar(
    SnackBar(
      content: Text(mensagem),
      action: SnackBarAction(
        label: "Fechar",
        onPressed: () {},
      ),
    ),
  );
}
