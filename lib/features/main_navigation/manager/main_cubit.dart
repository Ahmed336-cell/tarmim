import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityCubit() : super(true) {
    _checkInitialConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      emit(results.any((result) => result != ConnectivityResult.none));
    });
  }

  Future<void> _checkInitialConnectivity() async {
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    emit(results.any((result) => result != ConnectivityResult.none));
  }

  void checkConnection() => _checkInitialConnectivity();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
