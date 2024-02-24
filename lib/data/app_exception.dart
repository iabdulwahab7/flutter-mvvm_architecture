// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _message;
  final _prefix;

  //constructor
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchException extends AppException {
  FetchException([String? message])
      : super(message, 'Error during communication! ');
}

class InvalidRequestException extends AppException {
  InvalidRequestException([String? message])
      : super(message, 'Invalid Request! ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised Request! ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input! ');
}
