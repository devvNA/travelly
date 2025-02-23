// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';

import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/explore/pages/detail_destination_page.dart';

import '../../../core/constants/colors.dart';

class CardDestination extends StatelessWidget {
  final EventModel event;
  const CardDestination({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("Context push DetailDestinationPage");
        context.push(
          DetailDestinationPage(
            event: event,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 160,
        height: 232,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: event.image!.contains('events')
                      ? Image.asset(
                          Assets.images.adventure.path,
                          width: 160.0,
                          height: 128.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '${Variables.imageStorage}/events/${event.image}',
                          width: 160.0,
                          height: 128.0,
                          fit: BoxFit.cover,
                        ),
                ),
                const SpaceHeight(4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SpaceHeight(12),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                              text: '8.8/10',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: '(78)',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                color: Color(
                                  0xff687176,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        event.tickets!.isNotEmpty
                            ? FormatPrice()
                                .formatPrice(event.tickets![0].sku!.price!)
                                .currencyFormatRp
                            : "-",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.disable,
                          decorationThickness: 2.0,
                          color: AppColors.disable,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        event.tickets!.isNotEmpty
                            ? FormatPrice()
                                .formatPrice(event.tickets![0].sku!.price!)
                                .currencyFormatRp
                            : "-",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: const Color(0xff000000).withOpacity(0.53),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.white,
                      size: 10.0,
                    ),
                    SpaceWidth(4),
                    Text(
                      "Yogyakarta",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
