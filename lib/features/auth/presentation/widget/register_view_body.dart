import 'package:chat_master/features/auth/presentation/widget/auth_social_icons.dart';
import 'package:chat_master/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:chat_master/features/auth/presentation/widget/divider_with_text.dart';
import 'package:chat_master/features/auth/presentation/widget/dont_have_an_account_section.dart';
import 'package:chat_master/features/auth/presentation/widget/password.dart';
import 'package:chat_master/features/auth/presentation/widget/title_text.dart';
import 'package:flutter/material.dart';


class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/login.png',
            height: 200,
          ),
          CustomTitleText(title: "Create your account"),
          CustomTextFormField(
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          PasswordField(
              hintText: 'Password', passwordController: passwordController),
          PasswordField(
              hintText: 'Confirm Password',
              passwordController: confirmPasswordController),
          const SizedBox(height: 30),
          // CustomButton(onPressed: () {}, text: "Sign Up"),
          const SizedBox(height: 40),
          DividerWithText(
            text: " or sign up with",
          ),
          const SizedBox(height: 20),
          AuthSocialIcons(),
          DontHaveAnAccountSection(
            title: "Already have an account ?",
            buttonText: "Sign in",
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
