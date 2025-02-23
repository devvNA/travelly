import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/custom_text_field.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/login_request_model.dart';
import 'package:travelly/presentation/auth/blocs/login/login_bloc.dart';
import 'package:travelly/presentation/auth/pages/register_page.dart';
import 'package:travelly/presentation/home/pages/home_page.dart';
import 'package:travelly/presentation/partner/home/pages/home_partner_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPartnerPage extends StatefulWidget {
  const LoginPartnerPage({super.key});

  @override
  State<LoginPartnerPage> createState() => _LoginPartnerPageState();
}

class _LoginPartnerPageState extends State<LoginPartnerPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool showPassword = false;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
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
                    "Login",
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
                    "Login untuk melanjutkan perjalanan serumu bersama Ayo Piknik",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.textBlack2,
                    ),
                  ),
                  const SpaceHeight(32),
                  CustomTextField(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xff899CC9),
                      size: 16,
                    ),
                    controller: emailController!,
                    label: 'Email',
                    showLabel: true,
                  ),
                  const SpaceHeight(16),
                  CustomTextField(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Color(0xff899CC9),
                      size: 16,
                    ),
                    controller: passwordController!,
                    label: 'Password',
                    showLabel: true,
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPassword = !showPassword;
                        setState(() {});
                      },
                      icon: showPassword
                          ? const Icon(
                              Icons.visibility_off,
                              color: Color(0xff899CC9),
                              size: 16,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Color(0xff899CC9),
                              size: 16,
                            ),
                    ),
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
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (model) async {
                          await AuthLocalDatasource().saveAuthData(model);
                          if (model.data!.user!.isVendor == 1) {
                            context.pushReplacement(const HomePartnerPage());
                          } else {
                            context.pushReplacement(const HomePage());
                          }
                        },
                        error: (message) {
                          context.showSnackBar(message, AppColors.red);
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(orElse: () {
                        return Button.filled(
                          height: 48,
                          onPressed: () {
                            if (emailController!.text.isNotEmpty &&
                                passwordController!.text.isNotEmpty) {
                              final model = LoginRequestModel(
                                email: emailController!.text,
                                password: passwordController!.text,
                              );
                              context.read<LoginBloc>().add(
                                    LoginEvent.login(model),
                                  );
                            }
                          },
                          label: 'Login',
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
                        context.push(const RegisterPage());
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Don’t have an account?',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.textBlack2,
                              ),
                            ),
                            TextSpan(
                              text: ' Register',
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
        ));
  }
}
