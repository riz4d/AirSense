import 'dart:ui';

import 'package:airsens/core/theme/theme.dart';
import 'package:airsens/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LogListWidget extends StatefulWidget {
  final List<LogModel> logList;
  const LogListWidget({super.key, required this.logList});

  @override
  State<LogListWidget> createState() => _LogListWidgetState();
}

class _LogListWidgetState extends State<LogListWidget> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final logs = widget.logList;
    if (logs.isEmpty) {
      return Stack(
        children: [
          Shimmer.fromColors(
            enabled: false,
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[200],
                  elevation: 0,
                  child: ListTile(
                    title: Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.white,
                    ),
                    subtitle: Container(
                      width: double.infinity,
                      height: 14.0,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: w,
            height: h * .35,
            child: Center(
              child: Text(
                "No logs available",
                style: Palette.customTextStyle.copyWith(
                  fontSize: w * .05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return Card(
          child: ListTile(
              title: Text(
                "Sensor value - ${log.logString}",
                style: Palette.customTextStyle.copyWith(
                  fontSize: w * .04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Time - ${DateFormat('dd-MM-yyyy HH:mm a').format(DateTime.parse(log.logTime))}",
                style: Palette.customTextStyle.copyWith(
                  fontSize: w * .03,
                ),
              )),
        );
      },
    );
  }
}
