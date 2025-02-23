// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:travelly/presentation/order/pages/transaction_success_page.dart';

import '../pages/detail_order_page.dart';

class CardOrder extends StatelessWidget {
  final OrderModel order;
  const CardOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        order.orderTickets!.isNotEmpty &&
                order.orderTickets?[0].ticket?.status != 'redeem'
            ? context.push(DetailOrderPage(order: order))
            : context.push(TransactionSuccessPage(order: order));
      },
      child: Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No. Pesanan • CWB - ${order.id}",
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    order.eventDate!.toString(),
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              const SpaceHeight(12),
              Text(
                order.event!.name!,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack2,
                ),
              ),
              const SpaceHeight(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FormatPrice()
                        .formatPrice(order.totalPrice!)
                        .currencyFormatRp,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack2,
                    ),
                  ),
                  Text(
                    order.orderTickets!.isNotEmpty &&
                            order.orderTickets?[0].ticket?.status != null
                        ? order.orderTickets![0].ticket!.status!
                        : "redeem",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: order.orderTickets!.isNotEmpty &&
                              order.orderTickets?[0].ticket?.status != 'redeem'
                          ? AppColors.primary
                          : AppColors.orange,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
