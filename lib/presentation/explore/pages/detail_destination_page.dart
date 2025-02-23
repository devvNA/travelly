import 'package:flutter/material.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/explore/widgets/card_ticket.dart';
import 'package:travelly/presentation/explore/widgets/item_widget.dart';
import 'package:flutter_svg/svg.dart';

import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/presentation/explore/widgets/calender_item_widget.dart';

import '../../../core/assets/assets.gen.dart';

class DetailDestinationPage extends StatefulWidget {
  final EventModel event;
  const DetailDestinationPage({
    super.key,
    required this.event,
  });

  @override
  State<DetailDestinationPage> createState() => _DetailDestinationPageState();
}

class _DetailDestinationPageState extends State<DetailDestinationPage> {
  final DateTime today = DateTime.now();

  late List<DateTime> dates;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    dates = List.generate(7, (index) => today.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.lightBackground,
      body: ListView(
        children: [
          Stack(
            children: [
              widget.event.image!.contains('events')
                  ? Image.asset(
                      Assets.images.adventure.path,
                      width: context.deviceWidth,
                      height: 243.0,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      '${Variables.imageStorage}/events/${widget.event.image}',
                      width: context.deviceWidth,
                      height: 243.0,
                      fit: BoxFit.cover,
                    ),
              Container(
                height: 86,
                width: context.deviceWidth,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24.0,
                        color: AppColors.white,
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.icons.archiveBook.path,
                      width: 24.0,
                      height: 24.0,
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: context.deviceWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff000000).withAlpha(8),
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.event.name!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SpaceHeight(8),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '8.8/10',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' (dari 78 review)',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Color(
                            0xff687176,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SpaceHeight(10),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 24.0,
                      color: AppColors.primary,
                    ),
                    const SpaceWidth(8),
                    Expanded(
                      child: Text(
                        widget.event.vendor!.location!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SpaceHeight(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Pilihan Tiket",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack),
            ),
          ),
          const SpaceHeight(20),
          SizedBox(
            width: context.deviceWidth,
            height: 70,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dates.length + 1,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return const SpaceWidth(16);
              },
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                      width: 64,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.icons.menuBoard.path,
                          width: 24,
                          height: 24,
                        ),
                      ));
                } else {
                  final date = dates[index - 1];
                  final bool isToday = date.day == today.day &&
                      date.month == today.month &&
                      date.year == today.year;
                  return CalendarItemWidget(
                    isOutlined: false,
                    date: date,
                    isActive: activeIndex == index,
                    onTap: () {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    isToday: isToday,
                  );
                }
              },
            ),
          ),
          const SpaceHeight(24),
          ListView.separated(
            itemCount: widget.event.tickets!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return const SpaceHeight(
                16,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return CardTicket(
                event: widget.event,
                ticket: widget.event.tickets![index],
              );
            },
          ),
          const SpaceHeight(24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Nikmati Liburan Tanpa Batas",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack),
            ),
          ),
          const SpaceHeight(8),
          const ItemWidget(
            value:
                "Liburan jadi lebih seru! Dengan tiket High Season, Anda bisa menikmati wahana seru seperti Dunia Fantasi, Atlantis, Ocean Dream Samudra, hingga Pantai Ancol tanpa batas.",
          ),
          const SpaceHeight(8),
          const ItemWidget(
            value:
                "Cukup satu tiket untuk membuka pintu keseruan. Nikmati pengalaman seamless dengan sistem tiket digital yang praktis dan cepat.",
          ),
          const SpaceHeight(24),
        ],
      ),
    );
  }
}
