// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/presentation/partner/home/blocs/check_ticket/check_ticket_bloc.dart';
import 'package:travelly/presentation/partner/home/pages/home_partner_page.dart';
import 'package:travelly/presentation/partner/home/pages/scanner_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketStatusPage extends StatelessWidget {
  final bool isSuccess;
  const TicketStatusPage({
    super.key,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () {
              context
                  .read<CheckTicketBloc>()
                  .add(const CheckTicketEvent.started());
              context.pushReplacement(const HomePartnerPage());
            }),
        title: const Text(
          "Ticket Status",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: context.deviceWidth,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Image.asset(
              isSuccess
                  ? Assets.images.orderConfrimed.path
                  : Assets.images.orderFailed.path,
              width: 200.0,
              fit: BoxFit.cover,
            ),
            const SpaceHeight(16),
            Text(
              isSuccess
                  ? "Tiket berhasil diverifikasi:"
                  : "Tiket gagal diverifikasi:",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack2,
              ),
            ),
            const SpaceHeight(16),
            Text(
              isSuccess
                  ? "Tiket sudah terverifikasi dengan sukses. Pengunjung kini dapat melanjutkan tanpa hambatan dan menikmati pengalaman mereka dengan lancar."
                  : "Verifikasi gagal. Pastikan tiket yang Anda scan sudah benar dan coba lagi.",
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SpaceHeight(16),
            Button.filled(
              height: 48,
              color: isSuccess ? AppColors.primary : AppColors.red,
              onPressed: () {
                context
                    .read<CheckTicketBloc>()
                    .add(const CheckTicketEvent.started());
                if (isSuccess) {
                  context.pushReplacement(const HomePartnerPage());
                } else {
                  context.push(const ScannerPage());
                }
              },
              label: isSuccess ? 'Mengerti' : 'Scan Lagi',
            )
          ],
        ),
      ),
    );
  }
}
