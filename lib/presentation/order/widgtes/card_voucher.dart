// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:travelly/presentation/order/widgtes/qr_code_widget.dart';

class CardVoucher extends StatelessWidget {
  final OrderModel order;
  final OrderTicket orderTicket;
  const CardVoucher({
    super.key,
    required this.orderTicket,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xffE0E0E0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderTicket.ticket!.sku!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  orderTicket.ticket!.sku!.category!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppColors.white,
                    content: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: context.deviceWidth,
                          child: QRCodeWidget(
                            ticketCode: orderTicket.ticket!.ticketCode!,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: SizedBox(
              height: 60,
              width: 60,
              child: QRCodeWidget(
                ticketCode: orderTicket.ticket!.ticketCode!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
