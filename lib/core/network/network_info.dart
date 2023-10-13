import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoInterface {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfoInterface {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
