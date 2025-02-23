// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/presentation/explore/blocs/event/event_bloc.dart';
import 'package:travelly/presentation/explore/widgets/card_destination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentEvent extends StatelessWidget {
  const ContentEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Aktivitas Populer",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xff4B5563,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_outlined,
                color: Color(
                  0xff292D32,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 260,
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loading: () {
                  return const LoadingIndicator();
                },
                success: (data) {
                  return ListView.separated(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SpaceWidth(16);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CardDestination(
                        event: data[index],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        const SpaceHeight(10),
        Stack(
          children: [
            Container(
              height: 160,
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    AppColors.white,
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Voucher bermain di Ayo Piknik",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xff4B5563,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 260,
              padding: const EdgeInsets.all(16.0),
              width: context.deviceWidth,
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return const LoadingIndicator();
                    },
                    success: (data) {
                      return ListView.separated(
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SpaceWidth(16);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CardDestination(
                            event: data[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        Stack(
          children: [
            Container(
              height: 160,
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white,
                    AppColors.primary,
                    AppColors.white,
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Rekomendasi dari Ayo Piknik",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xff4B5563,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 260,
              padding: const EdgeInsets.all(16.0),
              width: context.deviceWidth,
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return const LoadingIndicator();
                    },
                    success: (data) {
                      return ListView.separated(
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SpaceWidth(16);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CardDestination(
                            event: data[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
