import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/presentation/explore/models/payment_option.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  PaymentOption? selectedPayment;

  final List<PaymentOption> eWallets = [
    PaymentOption(
      icon: Assets.images.dana.path,
      name: 'Dana',
      description: 'Bayar melalui dana',
    ),
  ];

  final List<PaymentOption> virtualAccounts = [
    PaymentOption(
      icon: Assets.images.bca.path,
      name: 'BCA',
      description: 'Bayar melalui virtual account',
    ),
    PaymentOption(
      icon: Assets.images.bri.path,
      name: 'Briva',
      description: 'Bayar melalui virtual account',
    ),
    PaymentOption(
      icon: Assets.images.mandiri.path,
      name: 'Mandiri',
      description: 'Bayar melalui virtual account',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const SpaceWidth(24),
                const Text(
                  'Pilih metode Pembayaranmu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack2,
                  ),
                ),
              ],
            ),
          ),
          _buildSection(title: 'E-wallet', items: eWallets),
          _buildSection(title: 'Virtual Account Bank', items: virtualAccounts),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Button.filled(
              borderRadius: 8,
              height: 40,
              onPressed: () {
                if (selectedPayment != null) {
                  Navigator.pop(context, selectedPayment);
                }
              },
              label: 'Konfirmasi',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<PaymentOption> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...items.map((item) => _buildPaymentItem(item)),
      ],
    );
  }

  Widget _buildPaymentItem(PaymentOption option) {
    return ListTile(
      leading: Image.asset(
        option.icon,
        width: 40,
        height: 40,
      ),
      title: Text(
        option.name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlack2,
        ),
      ),
      subtitle: Text(
        option.description,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.grey,
        ),
      ),
      trailing: Radio<PaymentOption>(
        value: option,
        groupValue: selectedPayment,
        onChanged: (PaymentOption? value) {
          setState(() {
            selectedPayment = value;
          });
        },
      ),
    );
  }
}
