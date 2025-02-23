// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';

class CardSkuPartner extends StatelessWidget {
  final SkuModel model;
  const CardSkuPartner({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      width: context.deviceWidth,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.id.toString(),
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Color(0xff687176),
            ),
          ),
          const SpaceHeight(10),
          Text(
            model.name ?? "-",
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack2),
          ),
          Text(
            model.event?.name ?? "-",
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Color(0xff687176),
            ),
          ),
          const SpaceHeight(10),
          Row(
            children: [
              Text(
                "Kuota: ${model.stock}",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xff687176),
                ),
              ),
              const SpaceWidth(4),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: FormatPrice()
                          .formatPrice(model.price!)
                          .currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: AppColors.orange,
                      ),
                    ),
                    const TextSpan(
                      text: '/pax',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(
                          0xff687176,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
