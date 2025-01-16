import 'dart:async';

import 'package:airsens/features/home/controller/home_controller.dart';
import 'package:airsens/features/home/providers/connectDevice_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gasDataNotifierProvider =
    AutoDisposeAsyncNotifierProvider<GasDataNotifier, double>(() {
  return GasDataNotifier();
});

class GasDataNotifier extends AutoDisposeAsyncNotifier<double> {
  Timer? _timer;

  @override
  FutureOr<double> build() {
    final isConnected = ref.watch(connectDeviceNotifierProvider).value;
    if (isConnected == null || isConnected == 0) {
      _cancelTimer();
      return 0.0;
    }

    _schedulePeriodicRefresh();
    return fetchCurrentGasData();
  }

  void _schedulePeriodicRefresh() {
    _cancelTimer(); // Ensure no existing timer is running

    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) {
        ref.invalidateSelf();
      },
    );

    ref.onDispose(() {
      _cancelTimer();
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<double> fetchCurrentGasData() async {
    return ref.read(homeControllerProvider.notifier).fetchCurrentGasData();
  }
}
