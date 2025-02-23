import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/custom_text_field.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/models/requests/create_sku_request_model.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:travelly/presentation/partner/sku/blocs/create_sku/create_sku_bloc.dart';
import 'package:travelly/presentation/partner/sku/blocs/get_skus/get_skus_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../event/blocs/get_event_user/get_event_user_bloc.dart';

class AddSkuPage extends StatefulWidget {
  const AddSkuPage({super.key});

  @override
  State<AddSkuPage> createState() => _AddSkuPageState();
}

class _AddSkuPageState extends State<AddSkuPage> {
  TextEditingController? nameTicketController;
  TextEditingController? categoryController;
  TextEditingController? priceController;
  TextEditingController? quotaController;
  EventModel? selectEvent;
  String? selectedDayType;

  @override
  void initState() {
    nameTicketController = TextEditingController();
    priceController = TextEditingController();
    categoryController = TextEditingController();
    quotaController = TextEditingController();
    context
        .read<GetEventUserBloc>()
        .add(const GetEventUserEvent.getEventUser());
    super.initState();
  }

  @override
  void dispose() {
    nameTicketController?.dispose();
    priceController?.dispose();
    quotaController?.dispose();
    categoryController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
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
            "Tambah Tiket",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          centerTitle: true,
          actions: const [],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocConsumer<CreateSkuBloc, CreateSkuState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  context.showSnackBar(message, Colors.red);
                },
                success: (message) {
                  context.showSnackBar(message, AppColors.primary);
                  context.read<GetSkusBloc>().add(const GetSkusEvent.getSkus());
                  context.pop();
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      final model = CreateSkuRequestModel(
                        name: nameTicketController!.text,
                        category: categoryController!.text,
                        eventId: selectEvent!.id,
                        price: int.parse(priceController!.text),
                        stock: int.parse(quotaController!.text),
                        dayType: selectedDayType,
                      );
                      context
                          .read<CreateSkuBloc>()
                          .add(CreateSkuEvent.createSku(model));
                    },
                    label: 'Simpan',
                  );
                },
                loading: () {
                  return const LoadingIndicator();
                },
              );
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            CustomTextField(
              prefixIcon: Image.asset(
                Assets.icons.ticket.path,
                width: 10.0,
                height: 10.0,
              ),
              borderColor: AppColors.grey,
              showLabel: true,
              controller: nameTicketController!,
              label: 'Nama Tiket',
            ),
            const SpaceHeight(
              16,
            ),
            CustomTextField(
              prefixIcon: Image.asset(
                Assets.icons.ticket.path,
                width: 10.0,
                height: 10.0,
              ),
              borderColor: AppColors.grey,
              showLabel: true,
              controller: categoryController!,
              label: 'Kategori',
            ),
            const SpaceHeight(
              16,
            ),
            const Text(
              "Event",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textBlack2,
              ),
            ),
            const SpaceHeight(6.0),
            BlocBuilder<GetEventUserBloc, GetEventUserState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const SizedBox.shrink();
                  },
                  loading: () {
                    return const LoadingIndicator();
                  },
                  success: (data) {
                    return DropdownButtonFormField<EventModel>(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            Assets.icons.a3dRotate.path,
                            width: 10.0,
                            height: 10.0,
                          ),
                        ),
                        // suffixIcon: const Icon(Icons.keyboard_arrow_down,
                        //     color: AppColors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      hint: const Text(
                        'Select Type',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textBlack2,
                        ),
                      ),
                      value: selectEvent,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textBlack2,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectEvent = newValue;
                        });
                      },
                      items: data.data!.map((EventModel option) {
                        return DropdownMenuItem<EventModel>(
                          value: option,
                          child: Text(option.name!),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
            const SpaceHeight(
              16,
            ),
            const Text(
              "Jenis Hari",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textBlack2,
              ),
            ),
            const SpaceHeight(6.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    Assets.icons.a3dRotate.path,
                    width: 10.0,
                    height: 10.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text(
                'Jenis Hari',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              value: selectedDayType, // nilai yang dipilih
              onChanged: (newValue) {
                setState(() {
                  selectedDayType = newValue;
                });
              },
              items: ['Hari Biasa', 'Akhir Pekan', 'Hari Libur Nasional']
                  .map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            const SpaceHeight(16),
            CustomTextField(
              prefixIcon: Image.asset(
                Assets.icons.moneys.path,
                width: 10.0,
                height: 10.0,
              ),
              borderColor: AppColors.grey,
              showLabel: true,
              keyboardType: TextInputType.number,
              controller: priceController!,
              label: 'Harga (Rp)',
            ),
            const SpaceHeight(
              16,
            ),
            CustomTextField(
              prefixIcon: Image.asset(
                Assets.icons.repeatCircle.path,
                width: 10.0,
                height: 10.0,
              ),
              borderColor: AppColors.grey,
              showLabel: true,
              controller: quotaController!,
              keyboardType: TextInputType.number,
              label: 'Kuota Tiket',
            ),
            const SpaceHeight(
              16,
            ),
          ],
        ));
  }
}
