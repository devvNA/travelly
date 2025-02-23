// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/explore/pages/destination_order_page.dart';

import '../../../data/models/responses/ticket_response_model.dart';

class CardTicket extends StatelessWidget {
  final EventModel event;
  final TicketEventModel ticket;
  const CardTicket({
    super.key,
    required this.event,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticket.sku!.name!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          const SpaceHeight(8),
          const Text(
            "Lihat Detail",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(10),
          const Divider(
            color: Color(0xffBDBDBD),
            thickness: 0.5,
          ),
          const SpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FormatPrice()
                        .formatPrice(ticket.sku!.price!)
                        .currencyFormatRp,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.disable,
                      decorationThickness: 2.0,
                      color: AppColors.disable,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    FormatPrice()
                        .formatPrice(ticket.sku!.price!)
                        .currencyFormatRp,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 132,
                height: 40,
                child: Button.filled(
                  borderRadius: 8,
                  onPressed: () {
                    context.push(DestinationOrder(
                      event: event,
                      ticket: ticket,
                    ));
                  },
                  label: 'Pilih',
                  fontSize: 16,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
