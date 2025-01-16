import 'package:airsens/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NormalValueSliderWidget extends StatefulWidget {
  final double value;
  final Function(dynamic)? onChanged;
  const NormalValueSliderWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<NormalValueSliderWidget> createState() =>
      _NormalValueSliderWidgetState();
}

class _NormalValueSliderWidgetState extends State<NormalValueSliderWidget> {
  late double _value;
  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SfSlider(
      activeColor: Palette.buttonColor,
      min: 0.0,
      max: 100.0,
      value: _value,
      interval: 10,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      minorTicksPerInterval: 1,
      onChangeEnd: widget.onChanged,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
