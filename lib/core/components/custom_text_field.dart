import 'package:flutter/material.dart';
import 'package:travelly/core/constants/colors.dart';

import 'spaces.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? capizalize;
  final bool showLabel;
  final Widget? suffixIcon;
  //prefixIcon
  final Widget? prefixIcon;
  final Color? color;
  final Color? borderColor;
  final bool? readOnly;
  //maxLines
  final int? maxLines;
  //text input action
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.capizalize,
    this.showLabel = false,
    this.suffixIcon,
    this.readOnly,
    this.borderColor = AppColors.primary,
    this.color = AppColors.white,
    this.maxLines = 1,
    this.prefixIcon,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textBlack2,
            ),
          ),
          const SpaceHeight(6.0),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: color,
            border: Border.all(
              color: borderColor!,
            ),
          ),
          child: TextFormField(
            readOnly: readOnly ?? false,
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: prefixIcon,
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide(color: color!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide(color: color!),
              ),
              hintText: label,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.textBlack2,
              ),
            ),
            textCapitalization: capizalize ?? TextCapitalization.words,
          ),
        ),
      ],
    );
  }
}
