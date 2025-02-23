// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/utils/datetime_utils.dart';
import 'package:travelly/data/models/requests/create_order_request_model.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/data/models/responses/ticket_response_model.dart';

class CardTicketPreview extends StatelessWidget {
  final EventModel event;
  final CreateOrderRequestModel model;
  final TicketEventModel? ticket;
  const CardTicketPreview({
    Key? key,
    required this.event,
    required this.model,
    this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: event.image!.contains('events')
                      ? Image.asset(
                          Assets.images.adventure.path,
                          width: 65.0,
                          height: 65.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '${Variables.imageStorage}/events/${event.image}',
                          width: 65.0,
                          height: 65.0,
                          fit: BoxFit.cover,
                        ),
                ),
                const SpaceWidth(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack2,
                        ),
                      ),
                      Text(
                        "Ticket: ${model.orderDetails!.length}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: context.deviceWidth,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline,
                    size: 20, color: AppColors.primary),
                const SpaceWidth(8),
                Text(
                  'Valid Pada : ${DateTimeUtils.formatDateToYMD(model.eventDate!)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
