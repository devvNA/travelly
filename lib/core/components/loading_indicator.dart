import 'package:flutter/material.dart';
import 'package:travelly/core/constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({this.color = AppColors.primary, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
