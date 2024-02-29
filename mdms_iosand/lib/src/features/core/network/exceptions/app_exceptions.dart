// ignore_for_file: prefer_typing_uninitialized_variables

class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return ('$_prefix $_message');
  }
}

class InternetExceptions extends AppExceptions {
  InternetExceptions([String? message]) : super(message, 'No Internet');
}

class RequestTimeOutExceptions extends AppExceptions {
  RequestTimeOutExceptions([String? message]) : super(message, 'Request Time Out');
}

class ServerExceptions extends AppExceptions {
  ServerExceptions([String? message]) : super(message, 'Internal Server Error');
}

class InvalidUrlExceptions extends AppExceptions {
  InvalidUrlExceptions([String? message]) : super(message, 'Invalid url');
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message]) : super(message, 'Error while feching data from server');
}