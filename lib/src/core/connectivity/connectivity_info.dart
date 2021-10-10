import 'package:connectivity/connectivity.dart';

abstract class ConnectivityInfo {
  Future<bool> get isConnected;
}

class ConnectivityInfoImpl implements ConnectivityInfo {
  ConnectivityInfoImpl(this.connectivity);

  final Connectivity connectivity;

  @override
  Future<bool> get isConnected => connectivity
      .checkConnectivity()
      .then((value) => value == ConnectivityResult.none ? false : true);
}
