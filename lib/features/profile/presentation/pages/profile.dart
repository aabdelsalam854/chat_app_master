
import 'package:cached_network_image/cached_network_image.dart';

import 'package:chat_master/features/auth/presentation/widget/password.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocProvider.value(
        value: sl<ProfileCubit>(),
        child: ProfileViewBody(user: user),
      ),
    );
  }
}

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController =
        TextEditingController(text: widget.user.phoneNumber ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
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
            //               ImagePickerHelper.imageSelector(image: ImageSource.gallery)
            //         .then((image) {
            //       if (image != null) {
            //         // رفع الصورة إلى Firebase بعد اختيارها
            //         UploadFileInFirebase.uploadFile(image).then((url) {
            //           context.read<ProfileCubit>().updateProfile(
            //                 UserModel(
            //                   id: widget.user.id,
            //                   name: nameController.text,
            //                   email: emailController.text,
            //                   phoneNumber: phoneController.text,
            //                   photoUrl: url,
            //                 ),
            //               );
            //         });
            //       }
            //     });
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
            CustomTextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            PasswordField(
                passwordController: phoneController, hintText: "hintText"),
            const SizedBox(height: 24),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تحديث البيانات بنجاح')),
                  );
                } else if (state is UpdateProfileErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('خطأ: ${state.error}')),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is UpdateProfileLoadingState;

                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    CustomButton(
                      onPressed: () {
                        context.read<ProfileCubit>().updatePassword(
                        "123456789"
                            );
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
