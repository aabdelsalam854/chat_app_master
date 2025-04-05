import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/login/presentation/manger/cubit/login_and_register_cubit.dart';
import 'package:chat_master/features/login/presentation/manger/cubit/login_and_register_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_bottom.dart';
import 'custom_text_bottom.dart';
import 'custom_text_form_field.dart';

class BodyRegisterView extends StatefulWidget {
  const BodyRegisterView({super.key});
  @override
  State<BodyRegisterView> createState() => _BodyRegisterViewState();
}

class _BodyRegisterViewState extends State<BodyRegisterView> {
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
        if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Center(child: Text('Account successfully created'))));
          GoRouter.of(context).pushReplacement(Routes.kLogin);
        } else if (state is RegisterFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text(state.errMessage))));
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
                        'Let\'s create an account for you ',
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
                          condition: state is! RegisterLoadingState,
                          fallback: (context) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.blue,
                            ));
                          },
                          builder: (context) {
                            return CustomBottom(
                              text: 'Sing Up',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.registerinFireBase(emailController.text,
                                      passwordController.text);
                                }
                              },
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already a membar?',
                              style: TextStyle(color: Color(0xFF424243))),
                          CustomTextBottom(
                              onPressed: () {
                                GoRouter.of(context).push("/");
                              },
                              text: 'Login Now')
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
