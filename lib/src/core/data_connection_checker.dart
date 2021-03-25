import 'package:data_connection_checker/data_connection_checker.dart';

import 'failure.dart';

class DataConnectionCheckerService {
  Future<void> checkConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (!result)
      throw Failure(
        'Please check your Wifi network or data service and try again',
      );
  }
}
