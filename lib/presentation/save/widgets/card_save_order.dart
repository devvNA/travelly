import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';

class CardSaveOrder extends StatelessWidget {
  const CardSaveOrder({super.key});

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
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                child: Image.asset(
                  Assets.images.waterSplash.path,
                  width: 67.0,
                  height: 67.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SpaceWidth(
                10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "[WEEKEND & HIGH SEASON] Tiket Jatim Park 1 + Museum Tubuh",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack2,
                      ),
                    ),
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
                  ],
                ),
              ),
              const SpaceHeight(
                16,
              ),
            ],
          ),
          const SpaceHeight(16),
          Row(
            children: [
              Image.asset(
                Assets.icons.locationWhite.path,
                width: 24.0,
                height: 24.0,
                fit: BoxFit.cover,
              ),
              const SpaceWidth(4),
              const Text(
                "Batu, Malang, Jawa Timur",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xff687176),
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Rp. 113.000 ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: AppColors.orange,
                      ),
                    ),
                    TextSpan(
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
          )
        ],
      ),
    );
  }
}
