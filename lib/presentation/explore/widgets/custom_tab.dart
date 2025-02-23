// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:travelly/core/constants/colors.dart';

class CustomTab extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;

  const CustomTab({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primary : AppColors.disable,
          BlendMode.srcIn,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10.0, overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
    );
  }
}
