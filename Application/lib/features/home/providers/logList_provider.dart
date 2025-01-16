import 'dart:async';

import 'package:airsens/features/home/controller/home_controller.dart';
import 'package:airsens/models/logFetch_paramModel.dart';
import 'package:airsens/models/log_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logListProvider =
    AutoDisposeAsyncNotifierProvider<LogListNotifier, List<LogModel>>(
  () => LogListNotifier(),
);

class LogListNotifier extends AutoDisposeAsyncNotifier<List<LogModel>> {
  @override
  Future<List<LogModel>> build() async {
    return await fetchLocalLogs();
  }

  LogFetchParamModel fetchParam = LogFetchParamModel(
    rowsPerPage: 10,
    currentPage: 1,
  );

  Future<List<LogModel>> fetchLocalLogs() async {
    return ref
        .read(homeControllerProvider.notifier)
        .fetchLocalLogs(fetchParam: fetchParam);
  }
}
