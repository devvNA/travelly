import 'package:flutter/material.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/presentation/order/blocs/get_orders_user/get_orders_user_bloc.dart';
import 'package:travelly/presentation/order/widgets/card_order.dart';
import 'package:travelly/presentation/order/widgets/empty_order_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrdersUserBloc>().add(const GetOrdersUserEvent.getOrders());
  }

  @override
  Widget build(BuildContext context) {
    // List<OrderModel> orders = [
    //   OrderModel(
    //     ticket: "CWB - 123456789012",
    //     date: "24 Des 2024 • 11:02",
    //     destination: "Adventure Fun Pass",
    //     price: "120000",
    //     status: "Pending",
    //     voucher: [
    //       VoucherModel(
    //         number: "Voucher  1",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  2",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  3",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //     ],
    //   ),
    //   OrderModel(
    //     ticket: "CWB - 123456789013",
    //     date: "24 Des 2024 • 11:02",
    //     destination: "Adventure Fun Pass",
    //     price: "120000",
    //     status: "Selesai",
    //     voucher: [
    //       VoucherModel(
    //         number: "Voucher  1",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  2",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  3",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //     ],
    //   ),
    //   OrderModel(
    //     ticket: "CWB - 123456789014",
    //     date: "24 Des 2024 • 11:02",
    //     destination: "Adventure Fun Pass",
    //     price: "120000",
    //     status: "Pending",
    //     voucher: [
    //       VoucherModel(
    //         number: "Voucher  1",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  2",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  3",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  4",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //     ],
    //   ),
    //   OrderModel(
    //     ticket: "CWB - 123456789013",
    //     date: "24 Des 2024 • 11:02",
    //     destination: "Adventure Fun Pass",
    //     price: "120000",
    //     status: "Selesai",
    //     voucher: [
    //       VoucherModel(
    //         number: "Voucher  1",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  2",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //       VoucherModel(
    //         number: "Voucher  3",
    //         description: "Pax (85 cm and above)",
    //         qrCode: Assets.images.qrCode.path,
    //       ),
    //     ],
    //   ),
    // ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: const SizedBox.shrink(),
        title: const Text(
          "Daftar Pesanan",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        actions: const [],
      ),
      body: BlocBuilder<GetOrdersUserBloc, GetOrdersUserState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox.shrink();
            },
            loading: () {
              return const LoadingIndicator();
            },
            success: (orders) {
              if (orders.data!.isEmpty) {
                return const EmptyOrderWidget();
              }
              return ListView.separated(
                itemCount: orders.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SpaceHeight(8);
                },
                itemBuilder: (BuildContext context, int index) {
                  return CardOrder(order: orders.data![index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
