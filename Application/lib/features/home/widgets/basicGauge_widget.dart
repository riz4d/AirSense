import 'package:airsens/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BasicGaugeWidget extends StatefulWidget {
  final double? value;
  final double normalValue;

  const BasicGaugeWidget({
    super.key,
    required this.value,
    required this.normalValue,
  });

  @override
  State<BasicGaugeWidget> createState() => _BasicGaugeWidgetState();
}

class _BasicGaugeWidgetState extends State<BasicGaugeWidget> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SfRadialGauge(
      animationDuration: 1000,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: widget.normalValue.toDouble(),
                color: Colors.green),
            GaugeRange(
                startValue: widget.normalValue.toDouble(),
                endValue: widget.normalValue + 10,
                color: Colors.orange),
            GaugeRange(
                startValue: widget.normalValue + 10,
                endValue: 100,
                color: Colors.red)
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: widget.value ?? 0,
              enableAnimation: true,
              animationDuration: 1000,
              animationType: AnimationType.easeInCirc,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  widget.value != null ? "${widget.value}" : "No readings",
                  style: Palette.customTextStyle.copyWith(
                    fontSize: w * .05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            )
          ],
        ),
      ],
    );
  }
}
