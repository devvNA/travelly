// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';

class TicketMenu extends StatelessWidget {
  final TicketEventModel ticketModel;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const TicketMenu({
    super.key,
    required this.ticketModel,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticketModel.sku!.name! + " (${ticketModel.ticketCount})",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                ),
              ),
              const SpaceHeight(4),
              Text(
                ticketModel.sku!.category!,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xff667085,
                  ),
                ),
              ),
              const SpaceHeight(16),
              Text(
                FormatPrice()
                    .formatPrice(ticketModel.sku!.price!)
                    .currencyFormatRp,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 112,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(
                        0xffE7EAED,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 2,
                      width: 12,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xff3949AB,
                        ),
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xff031222,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(
                        0xffE7EAED,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Color(
                        0xff3949AB,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
