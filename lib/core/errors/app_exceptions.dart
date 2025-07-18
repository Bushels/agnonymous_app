class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, {this.details});

  @override
  String toString() {
    return 'AppException: $message${details != null ? ' ($details)' : ''}';
  }
}

class NetworkException extends AppException {
  NetworkException(super.message, {super.details});

  @override
  String toString() {
    return 'NetworkException: $message${details != null ? ' ($details)' : ''}';
  }
}