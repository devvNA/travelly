import 'package:flutter/material.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/custom_text_field.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';

class DataCustomerPage extends StatefulWidget {
  const DataCustomerPage({super.key});

  @override
  State<DataCustomerPage> createState() => _DataCustomerPageState();
}

class _DataCustomerPageState extends State<DataCustomerPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneConroller;

  @override
  void initState() {
    nameController = TextEditingController(text: 'Saiful Bahri');
    emailController = TextEditingController(text: 'bahri@jagoflutter.com');
    phoneConroller = TextEditingController(text: '0812-3456-7890');
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    phoneConroller?.dispose();
    super.dispose();
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
          "Data Pemesan",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        width: context.deviceWidth,
        color: AppColors.white,
        child: Column(
          children: [
            CustomTextField(
              controller: nameController!,
              label: 'Nama Lengkap',
              showLabel: true,
            ),
            const SpaceHeight(
              16,
            ),
            CustomTextField(
              controller: emailController!,
              label: 'Nama Lengkap',
              showLabel: true,
            ),
            const SpaceHeight(
              16,
            ),
            CustomTextField(
              controller: phoneConroller!,
              label: 'No Handphone',
              showLabel: true,
            ),
            const SpaceHeight(
              56,
            ),
            Button.filled(
              color: AppColors.primary,
              label: "✦     Simpan     ✦",
              textColor: AppColors.white,
              onPressed: () {
                context.pop();
              },
            ),
            const SpaceHeight(
              20,
            ),
          ],
        ),
      ),
    );
  }
}
