import 'package:airsens/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorText;
  const ErrorText({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorText,
        style: Palette.customTextStyle.copyWith(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
