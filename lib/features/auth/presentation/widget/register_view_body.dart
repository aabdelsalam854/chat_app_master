import 'package:chat_master/core/constant/validation.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/core/widget/snack_bar.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';
import 'package:chat_master/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_master/features/auth/presentation/widget/auth_social_icons.dart';
import 'package:chat_master/features/auth/presentation/widget/divider_with_text.dart';
import 'package:chat_master/features/auth/presentation/widget/dont_have_an_account_section.dart';
import 'package:chat_master/features/auth/presentation/widget/password.dart';
import 'package:chat_master/features/auth/presentation/widget/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(24),
      child: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/login.png',
              height: 200,
            ),
            const CustomTitleText(title: "Create your account"),
            CustomTextFormField(
              controller: emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: Validation.emailValidator,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            CustomTextFormField(
              controller: nameController,
              hintText: 'name',
              keyboardType: TextInputType.name,
              validator: Validation.nameValidator,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 16),
            PasswordField(
              hintText: 'Password',
              passwordController: passwordController,
              validator: Validation.passwordValidator,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 16),
            PasswordField(
              hintText: 'Confirm Password',
              passwordController: confirmPasswordController,
              validator: Validation.passwordValidator,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 30),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthRegisterSuccessState) {
                  _cleanForm();
                  snackBar(
                      context: context,
                      text: "Register Success",
                      color: Colors.green);
                } else if (state is AuthRegisterFailureState) {
                  snackBar(
                      context: context, text: state.error, color: Colors.red);
                }
              },
              builder: (context, state) {
                return state is AuthRegisterLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onPressed: () {
                          _submitRegisterForm(context);
                        },
                        text: "Sign Up");
              },
            ),
            const SizedBox(height: 40),
            const DividerWithText(
              text: " or sign up with",
            ),
            const SizedBox(height: 20),
            const AuthSocialIcons(),
            DontHaveAnAccountSection(
              title: "Already have an account ?",
              buttonText: "Sign in",
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void _submitRegisterForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        if (context.mounted) {
          snackBar(
              context: context,
              text: "Passwords do not match",
              color: Colors.red);
        }

        return;
      }

      context.read<AuthCubit>().register(
            RegisterModel(
              email: emailController.text,
              password: passwordController.text,
              covariantPassword: confirmPasswordController.text,
              name: nameController.text,
              phoneNumber: "",
            ),
          );
    }
  }

  void _cleanForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
  }
}
