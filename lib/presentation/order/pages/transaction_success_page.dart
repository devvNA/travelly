// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';

import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/extensions/string_ext.dart';
import 'package:travelly/core/utils/format_price.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:travelly/presentation/order/pages/detail_order_page.dart';

class TransactionSuccessPage extends StatelessWidget {
  final OrderModel order;
  const TransactionSuccessPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        title: const Text(
          "Transaksi Selesai",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        actions: const [],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        height: 96,
        width: context.deviceWidth,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Button.filled(
          height: 48,
          onPressed: () {
            context.push(DetailOrderPage(order: order));
          },
          fontSize: 14.0,
          label: 'Lihat Tiket',
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 34,
            ),
            width: context.deviceWidth,
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: 104,
                  width: 104,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff9CA3AF).withOpacity(
                        0.3,
                      ),
                      width: 6,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.icons.check.path,
                      width: 54.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SpaceHeight(18),
                Text(
                  order.event!.name!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack2,
                  ),
                ),
                const Text(
                  "24 Des 2024 • 11:02",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(12),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            width: context.deviceWidth,
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Metode Pembayaran",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.textBlack2,
                      ),
                    ),
                    Text(
                      "BCA Virtual Account",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack2,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "No. Pesanan",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.textBlack2,
                      ),
                    ),
                    Text(
                      "${order.id}",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SpaceHeight(12),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            width: context.deviceWidth,
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pesanan",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack2,
                  ),
                ),
                const SpaceHeight(22),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.orderTickets!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SpaceHeight(16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final data = order.orderTickets![index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.ticket!.sku!.name!,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlack2,
                              ),
                            ),
                            Text(
                              FormatPrice()
                                  .formatPrice(data.ticket!.sku!.price!)
                                  .currencyFormatRp,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColors.textBlack2,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          data.totalQuantity.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack2,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SpaceHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack2,
                      ),
                    ),
                    Text(
                      order.totalPrice!.toIntegerFromText.currencyFormatRp,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
