import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/custom_date_picker.dart';
import 'package:travelly/core/components/custom_text_field.dart';
import 'package:travelly/core/components/image_picker_widget.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_event_request_model.dart';
import 'package:travelly/data/models/responses/event_category_response_model.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:travelly/presentation/partner/event/blocs/create_event/create_event_bloc.dart';
import 'package:travelly/presentation/partner/event/blocs/get_event_user/get_event_user_bloc.dart';
import 'package:travelly/presentation/explore/blocs/event_category/event_category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextEditingController? nameEventController;
  TextEditingController? descriptionController;
  TextEditingController? startDateController;
  TextEditingController? endDateController;
  DateTime? startDate;
  DateTime? endDate;
  LoginResponseModel? authData;
  EventCategoryModel? selectEventCategory;
  XFile? image;
  @override
  void initState() {
    nameEventController = TextEditingController();
    descriptionController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    context
        .read<EventCategoryBloc>()
        .add(const EventCategoryEvent.getEventCategories());
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    nameEventController?.dispose();
    descriptionController?.dispose();
    startDateController?.dispose();
    endDateController?.dispose();
    super.dispose();
  }

  loadData() async {
    authData = await AuthLocalDatasource().getAuthData();
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
            "Tambah Event",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          centerTitle: true,
          actions: const [],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(18.0),
          child: BlocConsumer<CreateEventBloc, CreateEventState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (message) async {
                  context.showSnackBar(message);
                  context
                      .read<GetEventUserBloc>()
                      .add(const GetEventUserEvent.getEventUser());
                  context.pop();
                },
                error: (message) {
                  context
                      .read<GetEventUserBloc>()
                      .add(const GetEventUserEvent.getEventUser());
                  context.showSnackBar(message, AppColors.red);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      final model = CreateEventRequestModel(
                        vendorId: authData!.data!.user!.vendor!.id!,
                        eventCategoryId: selectEventCategory!.id!,
                        image: image,
                        name: nameEventController!.text,
                        description: descriptionController!.text,
                        startDate: startDate,
                        endDate: endDate,
                      );
                      context
                          .read<CreateEventBloc>()
                          .add(CreateEventEvent.createEvent(model));
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
              controller: nameEventController!,
              label: 'Nama Event',
            ),
            const SpaceHeight(
              16,
            ),
            ImagePickerWidget(
              label: 'Gambar',
              onChanged: (file) {
                if (file != null) {
                  image = file;
                }
              },
            ),
            const SpaceHeight(
              16,
            ),
            // CustomTextField(
            //   prefixIcon: Image.asset(
            //     Assets.icons.clipboardText.path,
            //     width: 10.0,
            //     height: 10.0,
            //   ),
            //   borderColor: AppColors.grey,
            //   showLabel: true,
            //   controller: TextEditingController(text: 'Kategori'),
            //   suffixIcon:
            //       const Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
            //   label: 'Kategori',
            // ),
            const Text(
              "Kategori",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textBlack2,
              ),
            ),
            const SpaceHeight(6.0),
            BlocBuilder<EventCategoryBloc, EventCategoryState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const SizedBox.shrink();
                  },
                  loading: () {
                    return const LoadingIndicator();
                  },
                  success: (data) {
                    return DropdownButtonFormField<EventCategoryModel>(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            Assets.icons.clipboardText.path,
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
                      value: selectEventCategory,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textBlack2,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectEventCategory = newValue;
                        });
                      },
                      items: data.data!.map((EventCategoryModel option) {
                        return DropdownMenuItem<EventCategoryModel>(
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
            CustomTextField(
              prefixIcon: Image.asset(
                Assets.icons.clipboardText.path,
                width: 10.0,
                height: 10.0,
              ),
              borderColor: AppColors.grey,
              showLabel: true,
              controller: descriptionController!,
              label: 'Deskripsi',
              maxLines: 3,
            ),
            const SpaceHeight(
              16,
            ),
            CustomDatePicker(
              labelText: "Tanggal Berlaku",
              controller: startDateController!,
              onDateSelected: (date) {
                startDate = date;
              },
            ),
            const SpaceHeight(
              16,
            ),
            CustomDatePicker(
              labelText: "Tanggal Selesai",
              controller: endDateController!,
              onDateSelected: (date) {
                endDate = date;
              },
            ),
            const SpaceHeight(
              16,
            ),
          ],
        ));
  }
}
