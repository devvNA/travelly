// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:travelly/core/constants/colors.dart';

class CalendarItemWidget extends StatelessWidget {
  final DateTime date;
  final bool isActive;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isToday;

  const CalendarItemWidget({
    super.key,
    required this.date,
    required this.isActive,
    required this.onTap,
    required this.isOutlined,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final String dayName = DateFormat('EEE', 'id_ID')
        .format(date); // Nama hari (contoh: Sen, Sel, Rab)
    final String dayNumber = DateFormat('d MMM', 'id_ID')
        .format(date); // Format tanggal (contoh: 19 Des)

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive
              ? isOutlined
                  ? AppColors.white
                  : AppColors.primary
              : AppColors.white,
          borderRadius: BorderRadius.circular(
            8,
          ),
          border: Border.all(
            color: isActive
                ? isOutlined
                    ? AppColors.primary
                    : AppColors.white
                : AppColors.white,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            isToday
                ? Text(
                    "Hari Ini",
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive
                          ? isOutlined
                              ? AppColors.primary
                              : AppColors.white
                          : AppColors.disable,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? isOutlined
                              ? AppColors.primary
                              : AppColors.white
                          : AppColors.disable,
                    ),
                  ),

            const SizedBox(height: 4),
            // Teks tanggal
            Text(
              dayNumber,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive
                    ? isOutlined
                        ? AppColors.primary
                        : Colors.white
                    : AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
