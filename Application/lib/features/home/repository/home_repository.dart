import 'package:airsens/core/constants/app_constants.dart';
import 'package:airsens/core/error_handling/failure.dart';
import 'package:airsens/core/error_handling/handleErrors.dart';
import 'package:airsens/core/error_handling/type_defs.dart';
import 'package:airsens/core/providers/global_providers.dart';
import 'package:airsens/core/sqflite_db/databaseHelper.dart';
import 'package:airsens/models/logFetch_paramModel.dart';
import 'package:airsens/models/log_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(dio: ref.read(dioProvider));
});

class HomeRepository {
  final Dio dio;
  HomeRepository({required this.dio});
  FutureVoid storeLogToLocal({required LogModel logModel}) async {
    try {
      await db?.insert(
        'sensorLogs',
        logModel.toMap(),
      );

      final countResult =
          await db?.rawQuery('SELECT COUNT(*) AS count FROM sensorLogs');
      final count = countResult?.isNotEmpty == true
          ? countResult!.first['count'] as int
          : 0;

      if (count > 25) {
        await db?.rawDelete(
          '''
          DELETE FROM sensorLogs 
          WHERE logTime = (
            SELECT logTime FROM sensorLogs 
            ORDER BY logTime ASC 
            LIMIT 1
          )
          ''',
        );
      }

      return right(null);
    } catch (e) {
      return left(handleError(error: e));
    }
  }

  FutureEither<List<LogModel>> fetchLocalLogs(
      {required LogFetchParamModel fetchParam}) async {
    try {
      final List<Map<String, dynamic>> logs = await db!.query(
        'sensorLogs',
        orderBy: 'logTime DESC',
        limit: 20,
      );
      final List<LogModel> logModels =
          logs.map((e) => LogModel.fromMap(e)).toList();

      return right(logModels);
    } catch (e) {
      return left(handleError(error: e));
    }
  }

  FutureEither<double> fetchCurrentGasData() async {
    try {
      final response = await dio.get(AppConstants.gasData);

      if (response.statusCode == 200) {
        final sensorValue = response.data['sensorValue'].toString();
        await storeLogToLocal(
          logModel: LogModel(
            logTime: DateTime.now().toIso8601String(),
            logString: sensorValue,
          ),
        );
        return right(double.tryParse(sensorValue) ?? 0.0);
      } else {
        throw Exception(
            "Failed to fetch gas data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any errors and return a left value
      return left(handleError(error: e));
    }
  }

  FutureEither<int> fetchDeviceCurrentState() async {
    try {
      final response = await dio.get(AppConstants.currentDeviceState);
      if (response.statusCode == 200) {
        final deviceState = response.data['systemstate'];
        return right(deviceState);
      }
      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      return left(handleError(error: e));
    }
  }

  FutureEither<int> updateDeviceState({required int deviceState}) async {
    try {
      final response = await dio.post(
        AppConstants.updateDeviceState,
        data: {
          'systemState': deviceState,
        },
        options: Options(
          followRedirects: false, // Disable automatic redirection
          validateStatus: (status) {
            return status != null && status < 400 ||
                status == 308; // Allow status codes less than 400 and 308
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(deviceState);
      } else if (response.statusCode == 308) {
        // Handle the redirection manually
        final newUrl = response.headers['location']?.first;

        if (newUrl != null) {
          final redirectResponse = await dio.post(
            newUrl,
            data: {
              'systemState': deviceState,
            },
            options: Options(
              followRedirects: true,
              validateStatus: (status) {
                return status != null && status < 400;
              },
            ),
          );

          if (redirectResponse.statusCode == 200) {
            return right(deviceState);
          }
        }
      }

      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      return left(handleError(error: e));
    }
  }

  FutureEither<bool> clearLogs() async {
    try {
      await db!.delete('sensorLogs');
      return right(true);
    } catch (e) {
      return left(handleError(error: e));
    }
  }

  FutureEither<double> updateGaugeNormalValue(
      {required double normalValue}) async {
    try {
      final response = await dio.post(
        AppConstants.setDefaultValue,
        data: {
          'normalairValue': normalValue,
        },
        options: Options(
          followRedirects: false, // Disable automatic redirection
          validateStatus: (status) {
            return status != null && status < 400 ||
                status == 308; // Allow status codes less than 400 and 308
          },
        ),
      );
      if (response.statusCode == 200) {
        return right(normalValue);
      } else if (response.statusCode == 308) {
        final newUrl = response.headers['location']?.first;

        if (newUrl != null) {
          final redirectResponse = await dio.post(
            newUrl,
            data: {
              'normalairValue': normalValue,
            },
            options: Options(
              followRedirects: true,
              validateStatus: (status) {
                return status != null && status < 400;
              },
            ),
          );

          if (redirectResponse.statusCode == 200) {
            return right(normalValue);
          }
        }
      }

      throw "Something went wrong ${response.statusCode}";
    } catch (e) {
      return left(handleError(error: e));
    }
  }
}
