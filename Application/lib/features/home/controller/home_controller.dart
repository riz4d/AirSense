import 'package:airsens/core/widgets/customSnackBar_widget.dart';
import 'package:airsens/features/home/providers/connectDevice_provider.dart';
import 'package:airsens/features/home/providers/logList_provider.dart';
import 'package:airsens/features/home/providers/normalValue_provider.dart';
import 'package:airsens/features/home/repository/home_repository.dart';
import 'package:airsens/models/logFetch_paramModel.dart';
import 'package:airsens/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = NotifierProvider<HomeController, bool>(() {
  return HomeController();
});

class HomeController extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<void> storeLogToLocal({
    required LogModel logModel,
    required BuildContext context,
  }) async {
    final result = await ref
        .read(homeRepositoryProvider)
        .storeLogToLocal(logModel: logModel);
    result.fold(
      (failure) {
        return showSnackBar(
          content: failure.toString(),
          context: context,
          color: Colors.red,
          delay: false,
        );
      },
      (r) {},
    );
  }

  Future<List<LogModel>> fetchLocalLogs({
    required LogFetchParamModel fetchParam,
  }) async {
    final result = await ref
        .read(homeRepositoryProvider)
        .fetchLocalLogs(fetchParam: fetchParam);
    return result.fold(
      (failure) {
        throw Exception(failure.errMSg);
      },
      (logs) {
        return logs;
      },
    );
  }

  Future<double> fetchCurrentGasData() async {
    final result = await ref.read(homeRepositoryProvider).fetchCurrentGasData();
    return result.fold(
      (failure) {
        throw Exception(failure.errMSg);
      },
      (gasData) async {
        ref.invalidate(logListProvider);
        return gasData;
      },
    );
  }

  Future<int> fetchDeviceCurrentState() async {
    final result =
        await ref.read(homeRepositoryProvider).fetchDeviceCurrentState();
    return result.fold(
      (failure) {
        throw Exception(failure.errMSg);
      },
      (state) {
        return state;
      },
    );
  }

  Future<void> updateDeviceState({
    required int deviceState,
    required BuildContext context,
  }) async {
    state = true;
    final result = await ref
        .read(homeRepositoryProvider)
        .updateDeviceState(deviceState: deviceState);
    state = false;
    result.fold(
      (failure) {
        return showSnackBar(
          content: failure.errMSg.toString(),
          context: context,
          color: Colors.red,
          delay: false,
        );
      },
      (deviceState) {
        ref
            .read(connectDeviceNotifierProvider.notifier)
            .updateDeviceState(newState: deviceState);
      },
    );
  }

  Future<void> clearLogs({required BuildContext context}) async {
    state = true;
    final result = await ref.read(homeRepositoryProvider).clearLogs();
    state = false;
    result.fold(
      (failure) {
        return showSnackBar(
          content: failure.errMSg.toString(),
          context: context,
          color: Colors.red,
          delay: false,
        );
      },
      (r) {
        ref.invalidate(logListProvider);
      },
    );
  }

  Future<void> updateGaugeNormalValue({
    required double normalValue,
    required BuildContext context,
  }) async {
    final result = await ref
        .read(homeRepositoryProvider)
        .updateGaugeNormalValue(normalValue: normalValue);
    result.fold(
      (failure) {
        return showSnackBar(
          content: failure.errMSg.toString(),
          context: context,
          color: Colors.red,
          delay: false,
        );
      },
      (value) {
        ref.read(normalValueProvider.notifier).updateNormalValue(
              normalValue: value,
            );
        return showSnackBar(
          content: "Normal air value updated successfully",
          context: context,
          color: Colors.green,
          delay: false,
        );
      },
    );
  }
}
