import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String ticketCode;

  const QRCodeWidget({super.key, required this.ticketCode});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: ticketCode,
        version: QrVersions.auto,
        size: 200.0,
        gapless: false,
        backgroundColor: Colors.white,
      ),
    );
  }
}
