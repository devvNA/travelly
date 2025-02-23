import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';

class EmptySkuWidget extends StatelessWidget {
  const EmptySkuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.emptyTicket.path,
            width: 193.0,
            fit: BoxFit.cover,
          ),
          const SpaceHeight(4),
          const Text(
            "Belum ada tiket yang tersedia",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack2,
            ),
          ),
          const SpaceHeight(4),
          const Text(
            "Buat daftar tiket atraksi Anda sekarang untuk menarik lebih banyak pengunjung!",
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
