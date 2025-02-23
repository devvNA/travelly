// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';

class ItemMenu extends StatelessWidget {
  final String title;
  const ItemMenu({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 28,
      ),
      width: context.deviceWidth,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16.0, color: AppColors.grey),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primary,
          )
        ],
      ),
    );
  }
}
