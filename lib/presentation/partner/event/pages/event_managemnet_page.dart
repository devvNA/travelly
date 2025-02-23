import 'package:flutter/material.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/presentation/partner/event/blocs/get_event_user/get_event_user_bloc.dart';
import 'package:travelly/presentation/partner/event/pages/add_event_page.dart';
import 'package:travelly/presentation/partner/event/widgets/card_event.dart';
import 'package:travelly/presentation/partner/event/widgets/event_empty_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventManagemnetPage extends StatefulWidget {
  const EventManagemnetPage({super.key});

  @override
  State<EventManagemnetPage> createState() => _EventManagemnetPageState();
}

class _EventManagemnetPageState extends State<EventManagemnetPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetEventUserBloc>()
        .add(const GetEventUserEvent.getEventUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Event Management",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                context.push(const AddEventPage());
              },
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SpaceWidth(16)
          ],
        ),
        body: BlocBuilder<GetEventUserBloc, GetEventUserState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              loading: () {
                return const LoadingIndicator();
              },
              success: (data) {
                if (data.data!.isEmpty) {
                  return const EventEmptyWidget();
                }
                return ListView.separated(
                  itemCount: data.data!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SpaceHeight(2);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return CardEvent(event: data.data![index]);
                  },
                );
              },
            );
          },
        ));
  }
}
