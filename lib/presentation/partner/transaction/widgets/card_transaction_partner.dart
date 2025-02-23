// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';

class CardTransactionPartner extends StatelessWidget {
  final OrderModel order;
  const CardTransactionPartner({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.push(orderStatusPage(
        //   isSuccess: order.isSuccess ?? false,
        // ));
      },
      child: Container(
        width: context.deviceWidth,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(
                0xffE9F0F7,
              ),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.event!.name!,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack2,
                    ),
                  ),
                  const SpaceHeight(4),
                  const Text(
                    'CWB-20241201-0001',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.textBlack2,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceWidth(16),
            Text(
              FormatPrice().formatPrice(order.totalPrice!).currencyFormatRp,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
