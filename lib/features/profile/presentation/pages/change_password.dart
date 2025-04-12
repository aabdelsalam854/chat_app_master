import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_master/core/constant/validation.dart';

import 'package:chat_master/features/auth/presentation/widget/password.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_button.dart';

import 'package:chat_master/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_state.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: BlocProvider.value(
        value: sl<ProfileCubit>(),
        child: ChangePasswordBody(),
      ),
    );
  }
}

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({
    super.key,
  });
  // final UserModel user;

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();

  late final passwordController = TextEditingController();
  late final configPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    configPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              // GestureDetector(
              //   onTap: () {
              //           Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => ShowProfileImage(
              //                       imageUrl: widget.user.photoUrl!),
              //                 ),
              //               );
          
              //   },
              //   child: Stack(
              //     children: [
              //       Hero(
              //         tag: 'profile_image',
              //         child: Center(
              //           child: CircleAvatar(
              //             radius: 50,
              //             backgroundColor: Colors.grey[300],
              //             backgroundImage: NetworkImage(
              //               widget.user.photoUrl ??
              //                   'https://www.pngall.com/wp-content/uploads/5/Default-Profile-Picture-Avatar-Profile-PNG.png',
              //             ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         bottom: -1,
              //         right: 0,
              //         left: -120,
              //         child: Container(
              //           padding: const EdgeInsets.all(6),
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.white,
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black26,
              //                 blurRadius: 6,
              //                 offset: Offset(2, 2),
              //               ),
              //             ],
              //           ),
              //           child: IconButton(
              //             onPressed: () {
 
              //             },
              //             icon: const Icon(Icons.camera_alt),
              //             color: Colors.blue, // تغيير لون الأيقونة
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // CustomTextFormField(
              //   controller: nameController,
              //   keyboardType: TextInputType.name,
              // ),
              const SizedBox(height: 16),
              // CustomTextFormField(
              //   controller: emailController,
              //   keyboardType: TextInputType.emailAddress,
              // ),
              PasswordField(
                passwordController: passwordController,
                hintText: "كلمة المرور",
                validator: Validation.passwordValidator,
              ),
              const SizedBox(height: 16),
              PasswordField(
                passwordController: configPasswordController,
                hintText: "تأكيد كلمة المرور",
                validator: Validation.passwordValidator,
              ),
              const SizedBox(height: 24),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is UpdatePasswordSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تحديث البيانات بنجاح')),
                    );
                  } else if (state is UpdatePasswordErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('خطأ: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is UpdatePasswordLoadingState;
          
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomButton(
                        onPressed: () {
                          if (passwordController.text.trim() !=
                              configPasswordController.text.trim()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('كلمة المرور غير متطابقة'),
                              ),
                            );
                            return;
                          }
          
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<ProfileCubit>()
                                .updatePassword(passwordController.text.trim());
                          }
                        },
                        text: 'تحديث البيانات',
                      ),
                      if (isLoading)
                        const Positioned(
                          right: 12,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowProfileImage extends StatelessWidget {
  const ShowProfileImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عرض الصورة')),
      body: Center(
        child: Hero(
          tag: 'profile_image', // نفس الـ tag هنا
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            filterQuality: FilterQuality.high,
            width: 8500,
            height: 250,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              // width: 200,
              // height: 200,
              decoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                  //  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
