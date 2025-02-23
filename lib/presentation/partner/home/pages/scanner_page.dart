import 'package:flutter/material.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/presentation/partner/home/blocs/check_ticket/check_ticket_bloc.dart';
import 'package:travelly/presentation/partner/transaction/pages/ticket_status_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? _barcode;

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
      if (_barcode != null) {
        context.read<CheckTicketBloc>().add(
              CheckTicketEvent.checkTicket(
                _barcode!.rawValue!,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Verifikasi Tiket",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: BlocConsumer<CheckTicketBloc, CheckTicketState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              failure: (message) {
                context.showSnackBar(message, AppColors.red);
                context.pop();
                context.push(const TicketStatusPage(
                  isSuccess: false,
                ));
              },
              success: (data) {
                if (data.isValid!) {
                  context.pop();
                  context.showSnackBar(data.message!, AppColors.primary);
                  context.push(const TicketStatusPage(
                    isSuccess: true,
                  ));
                } else {
                  context.pop();
                  context.showSnackBar(data.message!, AppColors.red);
                  context.push(const TicketStatusPage(
                    isSuccess: false,
                  ));
                }
              });
        },
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                width: context.deviceWidth,
                child: MobileScanner(
                  onDetect: _handleBarcode,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: const Color(0xff40A2E3).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24)),
                  child: const Center(
                    child: Text(
                      'Kode QR akan otomatis terdeteksi saat Anda memposisikannya di antara garis panduan',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
