class Failure {
  final String message;
  final dynamic exception;
  Failure(
    this.message, {
    StackTrace? stackTrace,
    String? label,
    this.exception,
  });
}

class FailureUnknow extends Failure {
  FailureUnknow({
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
  }) : super(
          "Erro desconhecido. Vamos trabalhar para resolver!",
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
