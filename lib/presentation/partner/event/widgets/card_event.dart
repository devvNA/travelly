// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/utils/datetime_utils.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/partner/event/blocs/delete_event/delete_event_bloc.dart';
import 'package:travelly/presentation/partner/event/blocs/get_event_user/get_event_user_bloc.dart';
import 'package:travelly/presentation/partner/event/pages/edit_event_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardEvent extends StatelessWidget {
  final EventModel event;
  const CardEvent({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth,
      padding: const EdgeInsets.all(18.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              event.image == null || event.image!.contains('events')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        Assets.images.adventure.path,
                        width: 67.0,
                        height: 67.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${Variables.imageStorage}/events/${event.image}",
                        width: 67.0,
                        height: 67.0,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SpaceWidth(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name ?? "-",
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                    const SpaceHeight(8),
                    Text(
                      event.description ?? "-",
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Color(
                          0xff687176,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SpaceHeight(16),
          Row(
            children: [
              Text(
                "${DateTimeUtils.formatDateToYMD(event.startDate!)} - ${DateTimeUtils.formatDateToYMD(event.endDate ?? DateTime.now())}",
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Color(
                    0xff687176,
                  ),
                ),
              ),
              const Spacer(),
              BlocConsumer<DeleteEventBloc, DeleteEventState>(
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      success: (message) {
                        context.showSnackBar(message);
                        context
                            .read<GetEventUserBloc>()
                            .add(const GetEventUserEvent.getEventUser());
                      },
                      error: (message) {
                        context.showSnackBar(message, AppColors.red);
                      });
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return GestureDetector(
                        onTap: () {
                          context.read<DeleteEventBloc>().add(
                                DeleteEventEvent.deleteEvent(event.id!),
                              );
                        },
                        child: const Text(
                          "Hapus",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.red,
                          ),
                        ),
                      );
                    },
                    loading: () {
                      return const LoadingIndicator();
                    },
                  );
                },
              ),
              const SpaceWidth(12),
              GestureDetector(
                onTap: () {
                  context.push(EditEventPage(event: event));
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
