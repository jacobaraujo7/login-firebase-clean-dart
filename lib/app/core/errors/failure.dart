abstract class Failure implements Exception {
  String get message;
}

class ErrorLoginEmail extends Failure {
  final String message;
  ErrorLoginEmail({this.message});
}

class ErrorLoginPhone implements Failure {
  final String message;
  ErrorLoginPhone({this.message});
}

class NotAutomaticRetrieved implements Failure {
  final String verificationId;
  final String message;
  NotAutomaticRetrieved(this.verificationId, {this.message});
}

class InternalError implements Failure {
  final String message;
  InternalError({this.message});
}
