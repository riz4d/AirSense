import 'package:airsens/core/error_handling/error_text.dart';
import 'package:airsens/core/theme/theme.dart';
import 'package:airsens/core/widgets/customDialogeBox.dart';
import 'package:airsens/core/widgets/customSnackBar_widget.dart';
import 'package:airsens/core/widgets/loader.dart';
import 'package:airsens/core/widgets/overlay_loader.dart';
import 'package:airsens/features/home/controller/home_controller.dart';
import 'package:airsens/features/home/providers/connectDevice_provider.dart';
import 'package:airsens/features/home/providers/gasData_provider.dart';
import 'package:airsens/features/home/providers/logList_provider.dart';
import 'package:airsens/features/home/providers/normalValue_provider.dart';
import 'package:airsens/features/home/widgets/basicGauge_widget.dart';
import 'package:airsens/features/home/widgets/logList_widget.dart';
import 'package:airsens/features/home/widgets/normalValueSlider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final isLoading = ref.watch(homeControllerProvider);
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Air Sense',
          style: Palette.customTextStyle.copyWith(
            fontSize: w * .05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(w * .02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.4,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final isConnectedAsync =
                                  ref.watch(connectDeviceNotifierProvider);
                              final normalValueAsync =
                                  ref.watch(normalValueProvider);

                              if (isConnectedAsync.isLoading ||
                                  normalValueAsync.isLoading) {
                                return Center(child: Loader());
                              }

                              if (normalValueAsync.hasError) {
                                return ErrorText(
                                  errorText: 'Error: ${normalValueAsync.error}',
                                );
                              }

                              if (isConnectedAsync.hasError) {
                                return ErrorText(
                                  errorText: 'Error: ${isConnectedAsync.error}',
                                );
                              }

                              if (isConnectedAsync.value == null ||
                                  isConnectedAsync.value == 0) {
                                return Center(
                                  child: Text(
                                    'Please turn on the service',
                                    style: Palette.customTextStyle.copyWith(
                                      fontSize: w * .05,
                                    ),
                                  ),
                                );
                              }

                              final normalValue = normalValueAsync.value ?? 50;
                              final asyncValue =
                                  ref.watch(gasDataNotifierProvider);
                              return asyncValue.when(
                                data: (gasData) {
                                  return BasicGaugeWidget(
                                    value: gasData,
                                    normalValue: normalValue,
                                  );
                                },
                                loading: () => BasicGaugeWidget(
                                  value: null,
                                  normalValue: normalValue,
                                ),
                                error: (error, stackTrace) {
                                  return BasicGaugeWidget(
                                    value: null,
                                    normalValue: normalValue,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final asyncValue =
                                ref.watch(connectDeviceNotifierProvider);
                            return asyncValue.when(
                              data: (isConnected) {
                                return ToggleSwitch(
                                  minWidth: w * .2,
                                  minHeight: h * .05,
                                  initialLabelIndex: isConnected,
                                  cornerRadius: 20.0,
                                  activeFgColor: Palette.iconColor,
                                  inactiveBgColor: Colors.grey,
                                  inactiveFgColor: Palette.iconColor,
                                  totalSwitches: 2,
                                  icons: [
                                    FontAwesomeIcons.powerOff,
                                    FontAwesomeIcons.gaugeSimpleHigh,
                                  ],
                                  iconSize: 30.0,
                                  activeBgColors: [
                                    [Colors.red, Colors.redAccent],
                                    [Colors.green, Colors.lightGreenAccent]
                                  ],
                                  animate: true,
                                  curve: Curves.bounceInOut,
                                  onToggle: (index) {
                                    if (index != null) {
                                      ref
                                          .read(homeControllerProvider.notifier)
                                          .updateDeviceState(
                                            deviceState: index,
                                            context: context,
                                          );
                                    }
                                  },
                                );
                              },
                              loading: () => Loader(
                                isLinear: true,
                              ),
                              error: (error, stackTrace) => ErrorText(
                                errorText: error.toString(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: h * .01,
                        ),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final asyncValue = ref.watch(normalValueProvider);

                      return asyncValue.when(
                        data: (normalValue) {
                          return Card(
                            child: Container(
                              height: h * .13,
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * .01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Normal value",
                                    style: Palette.customTextStyle.copyWith(
                                      fontSize: w * .04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: NormalValueSliderWidget(
                                      value: normalValue,
                                      onChanged: (p0) async {
                                        await updateNormalValue(
                                            normalValue: p0);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return Card(
                            child: SizedBox(
                              height: h * .1,
                              child: Center(
                                child: Text(error.toString()),
                              ),
                            ),
                          );
                        },
                        loading: () {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: h * .1,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: h * .01),
                  Padding(
                    padding: EdgeInsets.all(w * .01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sensor Logs",
                              style: Palette.customTextStyle.copyWith(
                                fontSize: w * .05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await clearLogs();
                              },
                              child: Text(
                                'Clear logs',
                                style: Palette.customTextStyle.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: h * 0.3,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final asyncValue = ref.watch(logListProvider);
                              return asyncValue.when(
                                data: (logs) {
                                  return LogListWidget(logList: logs);
                                },
                                loading: () => Loader(),
                                error: (error, stackTrace) =>
                                    Text('Error: $error'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isLoading) LoadingOverlay(),
        ],
      ),
    );
  }

  Future<void> clearLogs() async {
    final shouldClear = await showCustomAlertDialog(
        context: context, content: "Are you sure?", pos: "Yes");
    if (shouldClear == true) {
      ref.read(homeControllerProvider.notifier).clearLogs(context: context);
    }
  }

  Future<void> updateNormalValue({required double normalValue}) async {
    final intNormalValue = normalValue.toDouble().toInt();

    final shouldClear = await showCustomAlertDialog(
        context: context,
        content: "Do you want to update normal value as $intNormalValue?",
        pos: "Yes");
    if (shouldClear == true) {
      await ref.read(homeControllerProvider.notifier).updateGaugeNormalValue(
            normalValue: normalValue,
            context: context,
          );
    }
  }
}
