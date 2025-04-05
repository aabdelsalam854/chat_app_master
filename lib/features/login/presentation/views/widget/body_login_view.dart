import 'dart:developer';
import 'package:chat_master/core/routes/routes.dart';

import 'package:chat_master/features/login/presentation/manger/cubit/login_and_register_cubit.dart';
import 'package:chat_master/features/login/presentation/manger/cubit/login_and_register_state.dart';
import 'package:chat_master/features/login/presentation/views/widget/custom_bottom.dart';
import 'package:chat_master/features/login/presentation/views/widget/custom_text_form_field.dart';
import 'package:chat_master/features/login/presentation/views/widget/custom_text_bottom.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BodyLoginView extends StatefulWidget {
  const BodyLoginView({super.key});
  @override
  State<BodyLoginView> createState() => _BodyLoginViewState();
}

class _BodyLoginViewState extends State<BodyLoginView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          // CacheData.setData(key: 'token', value: state.credential.user!.email);
          GoRouter.of(context).pushReplacement(Routes.kChatView,
              extra: state.credential.user!.email);
          log(state.credential.user!.uid.toString());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Center(child: Text('Login Successfully 💚')),
          ));
        } else if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Center(child: Text(state.errMessage)),
          ));
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginAndRegisterCubit>(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: Text(
                        'Welcome back you \'ve been missed!',
                        style: TextStyle(color: Color(0xFF424243)),
                      )),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'email',
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'password',
                          obscureText: cubit.showPassword,
                          icon: IconButton(
                              onPressed: () {
                                cubit.changeShowPassword();
                              },
                              icon: Icon(cubit.suffix))),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextBottom(
                              onPressed: () {}, text: 'Forget Password?')
                        ],
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (context) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.blue,
                          ));
                        },
                        builder: (context) => CustomBottom(
                            text: 'Login',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.loginInFireBase(
                                    emailController.text,
                                    passwordController.text);
                              }
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not a membar?',
                              style: TextStyle(color: Color(0xFF424243))),
                          CustomTextBottom(
                              onPressed: () {
                                GoRouter.of(context).push(Routes.kRegisterView);
                              },
                              text: 'Register Now')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
