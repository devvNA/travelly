import 'package:travelly/core/extensions/int_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_order_request_model.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:travelly/presentation/explore/blocs/create_order/create_order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/explore/dialogs/payment_dialog.dart';
import 'package:travelly/presentation/explore/models/payment_option.dart';
import 'package:travelly/presentation/explore/pages/payment_page.dart';
import 'package:travelly/presentation/explore/widgets/card_ticket_preview.dart';
import 'package:travelly/presentation/explore/widgets/dashedline.dart';

class OrderPreviewPage extends StatefulWidget {
  final CreateOrderRequestModel model;
  final EventModel event;
  final TicketEventModel ticket;
  final int total;
  const OrderPreviewPage({
    super.key,
    required this.event,
    required this.ticket,
    required this.model,
    required this.total,
  });

  @override
  State<OrderPreviewPage> createState() => _OrderPreviewPageState();
}

class _OrderPreviewPageState extends State<OrderPreviewPage> {
  PaymentOption? selectedPaymentOption;
  bool isDisable = false;
  LoginResponseModel? authData;
  int totalCountTicket = 0;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    authData = await AuthLocalDatasource().getAuthData();
    log("Model: ${widget.model.toJson()}");
    log("Event Model : ${widget.event.toJson()}");
    log("Ticket Model : ${widget.ticket.toJson()}");
    log("Total : ${widget.total}");
    final totalCount = widget.model.orderDetails!.map(
      (e) {
        totalCountTicket += e.qty!;
      },
    ).toList();
    setState(() {});
  }

  void showPaymentMethodSheet(BuildContext context) async {
    final result = await showModalBottomSheet<PaymentOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PaymentDialog(),
    );
    log("result: ${result?.name}");
    if (result != null) {
      setState(() {
        isDisable = false;
        selectedPaymentOption = result;
      });
    }
  }

  Widget _choisePayment(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Row(
        children: [
          const Text(
            "Mau bayar pakai metode apa?",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // showPaymentMethodSheet(context);
            },
            child: Container(
              height: 40,
              width: 74,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(
                  40,
                ),
              ),
              child: const Center(
                child: Text(
                  "Pilih",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          const SpaceWidth(8),
          const Icon(
            Icons.close,
            color: AppColors.white,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _payemntMethod(PaymentOption payment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
              bottom: BorderSide(
            width: 1.0,
            color: AppColors.grey.withOpacity(0.2),
          ))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showPaymentMethodSheet(context);
                },
                child: const Text(
                  "Pilih",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SpaceHeight(4),
          Row(
            children: [
              Image.asset(
                payment.icon,
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
              ),
              const SpaceWidth(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack2,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(
                    payment.description,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 20,
                height: 20,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
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
            "Lengkapi Data Pesanan",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: const [],
        ),
        bottomNavigationBar: SizedBox(
          height: selectedPaymentOption == null ? 236 : 280,
          child: Column(
            children: [
              selectedPaymentOption == null
                  ? _choisePayment(context)
                  : _payemntMethod(selectedPaymentOption!),
              Container(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Harga Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlack,
                              ),
                            ),
                            Text(
                              'Jumlah Ticket: ${totalCountTicket} ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.disable,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.total.currencyFormatRp,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SpaceHeight(12),
                    const DashedLine(),
                    const SpaceHeight(28),
                    BlocConsumer<CreateOrderBloc, CreateOrderState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          error: (error) {
                            context.showSnackBar(error, AppColors.red);
                          },
                          success: (data) {
                            context.push(
                              PaymentPage(
                                data: data,
                              ),
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            color: isDisable
                                ? AppColors.disable
                                : AppColors.primary,
                            label: "✦ Bayar Sekarang ✦",
                            textColor: isDisable
                                ? AppColors.white.withOpacity(0.5)
                                : AppColors.white,
                            onPressed: () {
                              context.read<CreateOrderBloc>().add(
                                    CreateOrderEvent.create(
                                      widget.model,
                                    ),
                                  );
                            },
                          );
                        }, loading: () {
                          return const LoadingIndicator();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: CardTicketPreview(
                event: widget.event,
                ticket: widget.ticket,
                model: widget.model,
              ),
            ),
            _item(
              Assets.icons.profileCircle.path,
              Text(
                authData?.data?.user?.email ?? "-",
                style: const TextStyle(fontSize: 16.0, color: AppColors.grey),
              ),
            ),
            const SpaceHeight(4),
            _item(
              Assets.icons.personalcard.path,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authData?.data?.user?.name ?? "-",
                    style:
                        const TextStyle(fontSize: 16.0, color: AppColors.grey),
                  ),
                  Text(
                    "${authData?.data?.user?.email} • ${authData?.data?.user?.phone ?? '-'}",
                    style:
                        const TextStyle(fontSize: 14.0, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            const SpaceHeight(4),
            Container(
              color: AppColors.white,
              child: ExpansionTile(
                shape: const Border(),
                backgroundColor: AppColors.white,
                childrenPadding: const EdgeInsets.all(16),
                trailing: const Icon(
                  Icons.keyboard_arrow_up,
                  color: AppColors.primary,
                ),
                leading: Image.asset(
                  Assets.icons.location.path,
                  width: 24.0,
                  height: 24.0,
                  fit: BoxFit.fill,
                ),
                title: const Text(
                  "Detail Lokasi",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),
                children: [
                  Text(
                    widget.event.vendor!.location!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xff687176,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _item(String image, Widget content) {
    return GestureDetector(
      onTap: () {
        // context.push(const DataCustomerPage());
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: AppColors.white,
        child: Row(
          children: [
            Image.asset(
              image,
              width: 52.0,
              height: 52.0,
              fit: BoxFit.cover,
            ),
            const SpaceWidth(10),
            Expanded(child: content),
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.primary.withOpacity(0.4),
              child: const Icon(
                Icons.check,
                size: 20,
                color: AppColors.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
