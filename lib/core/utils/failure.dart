abstract class Failure {
  final String message;
  final String? displayMessage;
  final int? statusCode;

  Failure({required this.message, this.displayMessage, this.statusCode});
}

class LocalFailure extends Failure {
  LocalFailure({
    required super.message,
    super.displayMessage,
    super.statusCode,
  });
}

class APIFailure extends Failure {
  APIFailure({
    required super.message,
    super.displayMessage,
    required super.statusCode,
  });
}
