import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/presentation/partner/profile_partner/blocs/get_vendor_user/get_vendor_user_bloc.dart';
import 'package:travelly/presentation/profile/widgets/card_vendor_account.dart';

class StatusAccountPage extends StatefulWidget {
  const StatusAccountPage({super.key});

  @override
  State<StatusAccountPage> createState() => _StatusAccountPageState();
}

class _StatusAccountPageState extends State<StatusAccountPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetVendorUserBloc>()
        .add(const GetVendorUserEvent.getVendorUser());
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
          "Status Akun",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: BlocBuilder<GetVendorUserBloc, GetVendorUserState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return state.maybeWhen(
              orElse: () {
                return SizedBox.shrink();
              },
              loading: () {
                return LoadingIndicator();
              },
              success: (data) {
                if (data.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "Data Kosong",
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: data.data!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SpaceHeight(16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return CardVendorAccount(vendor: data.data![index]);
                  },
                );
              },
            );
          });
        },
      ),
      // Container(
      //   height: context.deviceHeight / 2,
      //   padding: const EdgeInsets.all(16.0),
      //   width: context.deviceWidth,
      //   decoration: const BoxDecoration(
      //     color: AppColors.white,
      //   ),
      //   child: Column(children: [
      //     Image.asset(
      //       Assets.images.statusAccount.path,
      //       height: 194.0,
      //       fit: BoxFit.cover,
      //     ),
      //     const SpaceHeight(16),
      //     const Text(
      //       "Proses Verifikasi Sedang Berjalan!",
      //       style: TextStyle(
      //         fontSize: 16.0,
      //         fontWeight: FontWeight.w600,
      //         color: Color(
      //           0xff2E3139,
      //         ),
      //       ),
      //     ),
      //     const SpaceHeight(16),
      //     const Text(
      //       "Tim kami sedang memeriksa data Anda. Mohon tunggu sebentar, kami akan segera mengaktifkan akun Anda untuk mulai bergabung dengan Ayo Piknik.",
      //       style: TextStyle(
      //         fontSize: 14.0,
      //         fontWeight: FontWeight.w400,
      //         color: Color(
      //           0xffB2B2B2,
      //         ),
      //       ),
      //       textAlign: TextAlign.center,
      //     ),
      //     const SpaceHeight(16),
      //     Button.filled(
      //         height: 48, fontSize: 15.0, onPressed: () {}, label: 'Mengerti')
      //   ]),
      // ),
    );
  }
}
