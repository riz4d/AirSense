import 'dart:async';

import 'package:airsens/features/home/controller/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectDeviceNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ConnectDeviceNotifier, int>(() {
  return ConnectDeviceNotifier();
});

class ConnectDeviceNotifier extends AutoDisposeAsyncNotifier<int> {
  @override
  FutureOr<int> build() {
    return fetchCurrentState();
  }

  Future<int> fetchCurrentState() async {
    return ref.read(homeControllerProvider.notifier).fetchDeviceCurrentState();
  }

  void updateDeviceState({required int newState}) {
    state = AsyncData(newState);
  }
}
