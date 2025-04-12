import 'package:chat_master/config/locale/keys_translate.dart';
import 'package:chat_master/core/constant/validation.dart';
import 'package:chat_master/core/extensions/translate.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/core/widget/snack_bar.dart';
import 'package:chat_master/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_master/features/auth/presentation/widget/auth_social_icons.dart';
import 'package:chat_master/features/auth/presentation/widget/divider_with_text.dart';
import 'package:chat_master/features/auth/presentation/widget/dont_have_an_account_section.dart';
import 'package:chat_master/features/auth/presentation/widget/password.dart';
import 'package:chat_master/features/auth/presentation/widget/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/login.png',
                  height: 200,
                ),
                CustomTitleText(title: "Sign in to your account"),
                const SizedBox(height: 30),
                CustomTextFormField(
                  validator: Validation.emailValidator,
                  controller: emailController,
                  hintText: KeysTranslate.email.tr,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                PasswordField(
                    hintText: 'Password',
                    validator: Validation.passwordValidator,
                    passwordController: passwordController),
                const SizedBox(height: 30),
                Theme(
                  data: ThemeData(),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(Routes.kForgetPassword);
                            },
                            style: TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(50)),
                            child: const Text(
                              "Forget Password ?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoginSuccessState) {
                      snackBar( context:  context,text:  "Login Success",color:  Colors.green);
                      GoRouter.of(context).go(Routes.kHome);
                    } else if (state is AuthLoginFailureState) {
                      snackBar( context:  context,text:  state.error,color:  Colors.red);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        onPressed: () {
                          login(context);
                        },
                        text: "Sign in");
                  },
                ),
                const SizedBox(height: 40),
                DividerWithText(
                  text: "Or Sign in with",
                ),
                const SizedBox(height: 20),
                AuthSocialIcons(),
                const SizedBox(height: 30),
                DontHaveAnAccountSection(
                  title: "Don't have an account ?",
                  buttonText: "Sign up",
                  onPressed: () {
                    GoRouter.of(context).push(Routes.kRegisterView);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context
          .read<AuthCubit>()
          .login(emailController.text, passwordController.text);
    }
  }
}
