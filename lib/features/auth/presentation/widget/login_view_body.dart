import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_master/features/auth/presentation/widget/auth_social_icons.dart';
import 'package:chat_master/features/auth/presentation/widget/custom_text_form_field.dart';
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
  final String emailPattern =
      r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$';

  bool validateEmail(String email) {
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!validateEmail(value)) {
                  return "Email must be in the correct form";
                }
                return null;
              },
              controller: emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            PasswordField(
                hintText: 'Password', passwordController: passwordController),
            const SizedBox(height: 30),
            CustomButton(
                onPressed: () {
                  login(context);
                },
                text: "Sign in"),
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
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // context
      //     .read<AuthCubit>()
      //     .(emailController.text, passwordController.text);
    }
  }
}
