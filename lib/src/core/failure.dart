enum FailureType { nodata, error }

class Failure {
  final String message;
  final FailureType failureType;

  Failure(this.message, {this.failureType});

  @override
  String toString() => message;
}
