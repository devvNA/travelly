import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';

class EmptyOrderWidget extends StatelessWidget {
  const EmptyOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.emptyOrder.path,
            width: 296,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Pesanan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Anda belum memiliki pesanan. Mulai dengan membuat pesanan pertama Anda!',
            style: TextStyle(
              fontSize: 14,
              color: Color(
                0xffB2B2B2,
              ),
            ),
          ),
          const SpaceHeight(16),
          Button.filled(
            height: 48,
            onPressed: () {},
            label: 'Buat Pesanan',
          )
        ],
      ),
    );
  }
}
