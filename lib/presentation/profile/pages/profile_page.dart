import 'package:flutter/material.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/presentation/auth/blocs/logout/logout_bloc.dart';
import 'package:travelly/presentation/auth/pages/login_page.dart';
import 'package:travelly/presentation/auth/pages/register_partner_page.dart';
import 'package:travelly/presentation/profile/widgets/item_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: const SizedBox.shrink(),
          title: const Text(
            "Profil Pengguna",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          actions: const [],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(18.0),
          child: BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (message) async {
                  await AuthLocalDatasource().removeAuthData();
                  context.showSnackBar(
                    message,
                  );
                  context.pushReplacement(const LoginPage());
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context
                          .read<LogoutBloc>()
                          .add(const LogoutEvent.logout());
                    },
                    label: 'Logout',
                    color: AppColors.red,
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
          children: [
            Container(
              height: 200,
              width: context.deviceWidth,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.white.withOpacity(
                      0.2,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 50,
                    ),
                  ),
                  const SpaceHeight(24),
                  const Text(
                    "Saiful Bahri",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const Text(
                    "bahri@jagoflutter.com",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const ItemMenu(title: "Versi Aplikasi"),
            const SpaceHeight(4),
            const ItemMenu(title: "Syarat dan Ketentuan Layanan"),
            const SpaceHeight(4),
            const ItemMenu(title: "Kebijakan Privasi "),
            const SpaceHeight(4),
            const ItemMenu(title: "Tentang Ayo Piknik"),
            const SpaceHeight(4),
            GestureDetector(
                onTap: () {
                  context.push(RegisterPartnerPage());
                },
                child: const ItemMenu(title: "Gabung jadi Partner Ayo Piknik")),
          ],
        ));
  }
}
