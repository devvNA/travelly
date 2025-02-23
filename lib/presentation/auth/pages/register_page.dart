import 'package:flutter/material.dart';
import 'package:travelly/core/assets/assets.gen.dart';
import 'package:travelly/core/components/buttons.dart';
import 'package:travelly/core/components/custom_text_field.dart';
import 'package:travelly/core/components/spaces.dart';
import 'package:travelly/core/constants/colors.dart';
import 'package:travelly/core/extensions/build_context_ext.dart';
import 'package:travelly/core/components/loading_indicator.dart';
import 'package:travelly/data/models/requests/register_request_model.dart';
import 'package:travelly/presentation/auth/blocs/register/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  bool showPassword = false;
  bool showPasswordConfrim = false;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
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
                  "Registrasi sekarang dan temukan destinasi impianmu bersama kami.",
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
                  label: 'Name',
                  showLabel: true,
                ),
                const SpaceHeight(16),
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
                CustomTextField(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xff899CC9),
                    size: 16,
                  ),
                  controller: confirmPasswordController!,
                  label: 'Konfirmasi Password',
                  showLabel: true,
                  obscureText: !showPasswordConfrim,
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPasswordConfrim = !showPasswordConfrim;
                      setState(() {});
                    },
                    icon: showPasswordConfrim
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
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    state.maybeWhen(
                        orElse: () {},
                        error: (message) {
                          context.showSnackBar(message, AppColors.red);
                        },
                        loaded: (message) {
                          context.showSnackBar(message, AppColors.primary);
                          context.pop();
                        });
                  },
                  builder: (context, state) {
                    return state.maybeWhen(orElse: () {
                      return Button.filled(
                        height: 48,
                        onPressed: () {
                          final model = RegisterRequestModel(
                            name: nameController!.text,
                            email: emailController!.text,
                            password: passwordController!.text,
                            confirmPassword: confirmPasswordController!.text,
                          );
                          context.read<RegisterBloc>().add(
                                RegisterEvent.register(model),
                              );
                        },
                        label: 'Register',
                      );
                    }, loading: () {
                      return const LoadingIndicator();
                    });
                  },
                ),
                const SpaceHeight(16),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xffD3E0FE),
                        thickness: 1,
                      ),
                    ),
                    SpaceWidth(8),
                    Text(
                      "or",
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
                const SpaceHeight(16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Assets.images.google.path,
                        width: 14.0,
                        height: 14.0,
                        fit: BoxFit.cover,
                      ),
                      const Text(
                        'Login with Google',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SpaceWidth(10)
                    ],
                  ),
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
