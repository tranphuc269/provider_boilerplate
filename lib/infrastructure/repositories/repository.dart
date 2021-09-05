import 'package:connectivity/connectivity.dart';

export 'package:provider/provider.dart';
export 'package:flutter/widgets.dart';

class Repository {
  ///
  /// Offline / online judgment
  ///
  Future<bool> isOnline() async {
    final connectivity = await Connectivity().checkConnectivity();

    switch (connectivity) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;

      case ConnectivityResult.none:
      default:
        return false;
    }
  }
}