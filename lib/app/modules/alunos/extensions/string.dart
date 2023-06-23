extension ErrorFormTextString on String {
  String formatarErrorFormText() => replaceAll("[", "").replaceAll("]", "");
}
