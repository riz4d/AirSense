import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final normalValueProvider =
    AutoDisposeAsyncNotifierProvider<NormalValueNotifier, double>(
  () => NormalValueNotifier(),
);

class NormalValueNotifier extends AutoDisposeAsyncNotifier<double> {
  @override
  FutureOr<double> build() {
    return fetchNormalValue();
  }

  Future<double> fetchNormalValue() async {
    return 10;
  }

  void updateNormalValue({required double normalValue}) {
    state = AsyncData(normalValue);
  }
}
