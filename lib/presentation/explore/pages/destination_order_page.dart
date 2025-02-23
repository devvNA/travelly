// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';

import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/requests/create_order_request_model.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/explore/pages/order_preview_page.dart';
import 'package:travelly/presentation/explore/widgets/calender_item_widget.dart';
import 'package:travelly/presentation/explore/widgets/dashedline.dart';
import 'package:travelly/presentation/explore/widgets/ticket_menu.dart';

class DestinationOrder extends StatefulWidget {
  final EventModel event;
  final TicketEventModel ticket;

  // final DestinationModel destination;
  const DestinationOrder({
    super.key,
    required this.event,
    required this.ticket,
  });

  @override
  State<DestinationOrder> createState() => _DestinationOrderState();
}

class _DestinationOrderState extends State<DestinationOrder> {
  final DateTime today = DateTime.now();
  final Map<int, int> skuIdCount = {};
  late List<DateTime> dates;
  int activeIndex = 1;
  late DateTime selectedDate;
  int totalPrice = 0;
  @override
  void initState() {
    super.initState();
    dates = List.generate(7, (index) => today.add(Duration(days: index)));
    selectedDate = dates[activeIndex];
    for (var ticket in widget.event.tickets!) {
      skuIdCount[ticket.sku!.id!] = 0;
    }
  }

  void updateTicketCount(int skuId, int delta) {
    setState(() {
      final currentCount = skuIdCount[skuId] ?? 0;
      skuIdCount[skuId] = (currentCount + delta).clamp(0, 100);
    });
    totalPrice = skuIdCount.entries.fold(
      0,
      (sum, entry) {
        final ticket =
            widget.event.tickets!.firstWhere((t) => t.sku!.id == entry.key);
        return sum +
            (entry.value * FormatPrice().formatPrice(ticket.sku!.price!))
                .toInt();
      },
    );
    log("SKU ID: $skuId, Quantity: ${skuIdCount[skuId]}");
  }

  void proceedToOrderPreview() {
    final selectedDate = dates[activeIndex];
    final List<OrderDetail> orderDetails = [];

    skuIdCount.forEach((skuId, count) {
      if (count > 0) {
        orderDetails.add(OrderDetail(skuId: skuId, qty: count));
        log("SKU ID: $skuId, Quantity: $count");
      }
    });

    final totalSku = skuIdCount.values.fold(0, (sum, count) => sum + count);

    final createOrderRequest = CreateOrderRequestModel(
      orderDetails: orderDetails,
      eventId: widget.event.id,
      quantity: totalSku,
      eventDate: selectedDate,
    );
    setState(() {});

    context.push(
      OrderPreviewPage(
        event: widget.event,
        ticket: widget.ticket,
        model: createOrderRequest,
        total: totalPrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        title: const Text(
          "Tambah Jumlah Pengunjung",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      bottomNavigationBar: Container(
        height: 180,
        padding: const EdgeInsets.all(
          16,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(
              color: Color(
                0xffF6F6F6,
              ),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harga Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    Text(
                      'Sudah termasuk pajak',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.disable,
                      ),
                    ),
                  ],
                ),
                Text(
                  totalPrice.currencyFormatRp,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
            const SpaceHeight(12),
            const DashedLine(),
            const SpaceHeight(28),
            Button.filled(
              label: "✦ Pesan Sekarang ✦",
              onPressed: proceedToOrderPreview,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: context.deviceWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff000000).withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: widget.event.image!.contains('events')
                      ? Image.asset(
                          Assets.images.adventure.path,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '${Variables.imageStorage}/events/${widget.event.image}',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                ),
                const SpaceWidth(
                  20,
                ),
                Expanded(
                  child: Text(
                    widget.event.name!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(16),
          SizedBox(
            width: context.deviceWidth,
            height: 88,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dates.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return const SpaceWidth(12);
              },
              itemBuilder: (BuildContext context, int index) {
                final date = dates[index];
                final bool isToday = date.day == today.day &&
                    date.month == today.month &&
                    date.year == today.year;

                return CalendarItemWidget(
                  isToday: isToday,
                  isOutlined: true,
                  date: date,
                  isActive: activeIndex == index,
                  onTap: () {
                    setState(() {
                      activeIndex = index;
                      selectedDate = dates[index];
                    });
                  },
                );
              },
            ),
          ),
          const SpaceHeight(16),
          const Center(
            child: Text(
              "Voucer bisa dipakai pada",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SpaceHeight(8),
          const Center(
            child: Text(
              "Kamis, 19 Desember 2024",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
          ),
          const SpaceHeight(
            16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            width: context.deviceWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff000000).withOpacity(0.2),
                  width: 0.5,
                ),
                top: BorderSide(
                  color: const Color(0xff000000).withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.event.tickets!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SpaceHeight(
                  16,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return TicketMenu(
                  ticketModel: widget.event.tickets![index],
                  count: skuIdCount[widget.event.tickets![index].sku!.id!] ?? 0,
                  onIncrement: () => updateTicketCount(
                      widget.event.tickets![index].sku!.id!, 1),
                  onDecrement: () => updateTicketCount(
                      widget.event.tickets![index].sku!.id!, -1),
                );
              },
            ),
          ),
          const SpaceHeight(
            52,
          )
        ],
      ),
    );
  }
}
