import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/custom_text_field.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_vendor_request_model.dart';
import 'package:travelly/data/models/responses/event_category_response_model.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:travelly/presentation/auth/blocs/create_vendor/create_vendor_bloc.dart';
import 'package:travelly/presentation/auth/pages/login_partner_page.dart';
import 'package:travelly/presentation/explore/blocs/event_category/event_category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPartnerPage extends StatefulWidget {
  const RegisterPartnerPage({super.key});

  @override
  State<RegisterPartnerPage> createState() => _RegisterPartnerPageState();
}

class _RegisterPartnerPageState extends State<RegisterPartnerPage> {
  TextEditingController? nameController;
  // TextEditingController? emailController;
  TextEditingController? phoneNumberController;
  TextEditingController? placeController;
  TextEditingController? addressController;
  EventCategoryModel? selectedCategory;
  LoginResponseModel? authData;
  @override
  void initState() {
    nameController = TextEditingController();
    // emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    placeController = TextEditingController();
    addressController = TextEditingController();
    context
        .read<EventCategoryBloc>()
        .add(const EventCategoryEvent.getEventCategories());
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    // emailController?.dispose();
    phoneNumberController?.dispose();
    placeController?.dispose();
    addressController?.dispose();
    super.dispose();
  }

  loadData() async {
    authData = await AuthLocalDatasource().getAuthData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Stack(
        children: [
          Container(
            height: context.deviceHeight / 3,
            width: context.deviceWidth,
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Center(
              child: Image.asset(
                Assets.images.logoWhite.path,
                width: 280,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(24, context.deviceHeight * 0.25, 24, 24),
            height: context.deviceHeight * 0.8,
            width: context.deviceWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 32,
              ),
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack2,
                  ),
                ),
                const SpaceHeight(
                  8,
                ),
                const Text(
                  "Bergabung jadi partner kami dan jangkau lebih banyak pelanggan.",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.textBlack2,
                  ),
                ),
                const SpaceHeight(32),
                CustomTextField(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color(0xff899CC9),
                    size: 16,
                  ),
                  controller: nameController!,
                  label: 'Name Bisnis',
                  showLabel: true,
                ),
                // const SpaceHeight(16),
                // CustomTextField(
                //   prefixIcon: const Icon(
                //     Icons.email_outlined,
                //     color: Color(0xff899CC9),
                //     size: 16,
                //   ),
                //   controller: emailController!,
                //   label: 'Email',
                //   showLabel: true,
                // ),
                const SpaceHeight(16),
                CustomTextField(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xff899CC9),
                    size: 16,
                  ),
                  controller: phoneNumberController!,
                  label: 'No Handphone',
                  showLabel: true,
                ),
                const SpaceHeight(16),
                CustomTextField(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xff899CC9),
                    size: 16,
                  ),
                  controller: placeController!,
                  label: 'Tempat Beroperasi',
                  showLabel: true,
                ),
                const SpaceHeight(16),
                CustomTextField(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xff899CC9),
                    size: 16,
                  ),
                  controller: addressController!,
                  label: 'Lokasi Tempat Wisata',
                  showLabel: true,
                ),
                const SpaceHeight(16),
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
                          value: selectedCategory,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textBlack2,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue;
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
                const SpaceHeight(16),
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 12,
                      ),
                    ),
                    const SpaceWidth(8),
                    const Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.textBlack2,
                      ),
                    )
                  ],
                ),
                const SpaceHeight(32),
                BlocConsumer<CreateVendorBloc, CreateVendorState>(
                  listener: (context, state) {
                    state.maybeWhen(
                        orElse: () {},
                        error: (message) {
                          context.showSnackBar(message, AppColors.red);
                        },
                        success: (message) {
                          context.showSnackBar(message, AppColors.primary);
                          context.push(LoginPartnerPage());
                        });
                  },
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return Button.filled(
                        height: 48,
                        onPressed: () {
                          final model = CreateVendorRequestModel(
                            name: nameController!.text,
                            city: placeController!.text,
                            description: '-',
                            location: addressController!.text,
                            phone: phoneNumberController!.text,
                            userId: authData!.data!.user!.id,
                          );
                          context.read<CreateVendorBloc>().add(
                                CreateVendorEvent.createVendor(model),
                              );
                        },
                        label: 'Register',
                      );
                    }, loading: () {
                      return const LoadingIndicator();
                    });
                  },
                ),
                const SpaceHeight(32),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: '',
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.textBlack2,
                            ),
                          ),
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
