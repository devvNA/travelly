// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:travelly/presentation/explore/widgets/dashedline.dart';

import 'package:travelly/presentation/order/widgtes/card_voucher.dart';

class DetailOrderPage extends StatefulWidget {
  final OrderModel order;
  const DetailOrderPage({
    super.key,
    required this.order,
  });

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Stack(
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.all(16.0),
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    widget.order.event!.name!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const SpaceWidth(10)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 92, 12, 24),
              height: context.deviceHeight * 0.8,
              width: context.deviceWidth,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  14,
                ),
              ),
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          Assets.images.borobudur.path,
                          width: 78,
                          height: 78,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SpaceWidth(18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.order.event!.name!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlack2,
                            ),
                          ),
                          Text(
                            widget.order.event?.vendor?.location ?? '-',
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SpaceHeight(24),
                  Text(
                    widget.order.event!.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack2,
                    ),
                  ),
                  Text(
                    "${widget.order.quantity} tiket",
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SpaceHeight(60),
                  const DashedLine(),
                  const SpaceHeight(40),
                  ListView.separated(
                    itemCount: widget.order.orderTickets!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SpaceHeight(12);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CardVoucher(
                        orderTicket: widget.order.orderTickets![index],
                        order: widget.order,
                      );
                    },
                  ),
                  const SpaceHeight(40),
                  _buildInfo(),
                ],
              ),
            ),
            _scrollPosition < 179
                ? Positioned(
                    top: (_scrollPosition < 300) ? 300 - _scrollPosition : 0,
                    child: _buildCurvedEdges(context),
                  )
                : const SizedBox.shrink()
          ],
        ));
  }

  Widget _buildCurvedEdges(BuildContext context) {
    return SizedBox(
      width: context.deviceWidth,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSemiCircle(),
          _buildSemiCircle(),
        ],
      ),
    );
  }

  Widget _buildSemiCircle() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: AppColors.lightBackground,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 20, color: AppColors.primary),
          SpaceWidth(8),
          Text(
            'Valid Pada : 24 Desember 2024',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textBlack2,
            ),
          ),
        ],
      ),
    );
  }
}
