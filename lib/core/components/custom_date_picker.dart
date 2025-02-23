import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/constants/colors.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.labelText,
    required this.controller,
    required this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label di luar TextField
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textBlack2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: Image.asset(
                  Assets.icons.videoTime.path,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            hintText: "Pilih Tanggal",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  const BorderSide(color: AppColors.grey), // Warna border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  const BorderSide(color: AppColors.grey), // Warna border fokus
            ),
          ),
        ),
      ],
    );
  }
}
