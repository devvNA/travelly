import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/extensions/string_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:travelly/presentation/partner/home/pages/dashboard_partner_page.dart';
import 'package:travelly/presentation/partner/transaction/blocs/get_orders_vendor/get_orders_vendor_bloc.dart';
import 'package:travelly/presentation/partner/transaction/blocs/get_total_orders_vendor/get_total_orders_vendor_bloc.dart';
import 'package:travelly/presentation/partner/transaction/widgets/card_transaction_partner.dart';
import 'package:travelly/presentation/partner/transaction/widgets/empty_transaction_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPartnerPage extends StatefulWidget {
  const TransactionPartnerPage({super.key});

  @override
  State<TransactionPartnerPage> createState() => _TransactionPartnerPageState();
}

class _TransactionPartnerPageState extends State<TransactionPartnerPage> {
  LoginResponseModel? loginResponseModel;
  loadData() async {
    loginResponseModel = await AuthLocalDatasource().getAuthData();
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    context
        .read<GetOrdersVendorBloc>()
        .add(const GetOrdersVendorEvent.getOrders());
    context
        .read<GetTotalOrdersVendorBloc>()
        .add(const GetTotalOrdersVendorEvent.getTotalOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          const SpaceHeight(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    Assets.images.profileImage.path,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SpaceWidth(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      loginResponseModel?.data!.user?.name ?? "",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  Assets.icons.ticketIcon.path,
                  width: 24.0,
                  height: 24.0,
                  fit: BoxFit.cover,
                ),
                const SpaceWidth(4),
                GestureDetector(
                  onTap: () {
                    context.push(const DashboardPartnerPage());
                  },
                  child: const Text(
                    "E-tiket",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(8),
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            width: context.deviceWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(
                    0.6,
                  ),
                  AppColors.primary
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pendapatan",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white.withOpacity(0.72),
                  ),
                ),
                BlocBuilder<GetTotalOrdersVendorBloc,
                    GetTotalOrdersVendorState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const SizedBox.shrink();
                      },
                      loading: () {
                        return const LoadingIndicator();
                      },
                      success: (totalOrder) {
                        return Text(
                          totalOrder.toIntegerFromText.currencyFormatRp,
                          style: const TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SpaceHeight(32),
          const Divider(
            color: AppColors.lightBackground,
            thickness: 5,
          ),
          const SpaceHeight(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xffD3E0FE),
                    thickness: 1,
                  ),
                ),
                SpaceWidth(8),
                Text(
                  "Transaksi",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.textBlack2,
                  ),
                ),
                SpaceWidth(8),
                Expanded(
                  child: Divider(
                    color: Color(0xffD3E0FE),
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(16),
          BlocBuilder<GetOrdersVendorBloc, GetOrdersVendorState>(
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
                    return const EmptyTransactionWidget();
                  }
                  return ListView.builder(
                    itemCount: data.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CardTransactionPartner(
                        order: data.data![index],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
