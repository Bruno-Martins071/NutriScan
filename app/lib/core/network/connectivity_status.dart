import 'package:connectivity_plus/connectivity_plus.dart';

abstract final class ConnectivityStatus {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> get isOnline async =>
      _hasConnection(await _connectivity.checkConnectivity());

  static Stream<bool> get onChanged =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  static bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
