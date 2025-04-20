import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/utils/cam.dart';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_circle_network_image.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_state.dart';
import 'package:chat_master/features/profile/presentation/pages/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ProfileViewBody(
        user: user,
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
  late final nameController = TextEditingController();
  late final emailController = TextEditingController();
  late final phoneController = TextEditingController();
  late final statusController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    phoneController.text = widget.user.phoneNumber!;
    statusController.text = widget.user.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
            ),
          );
        } else if (state is UpdateProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'),
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowProfileImage(
                                  imageUrl: widget.user.photoUrl!),
                            ),
                          );
                        },
                        child: Hero(
                          tag: widget.user.photoUrl ?? "",
                          child: CustomCircleNetworkImage(
                              radius: 130,
                              imageUrl: widget.user.photoUrl ?? ""),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 40,
                        child: GestureDetector(
                          onTap: () {
                            ImagePickerHelper.imageSelector(
                                    image: ImageSource.gallery)
                                .then((image) {
                              if (image != null) {
                                UploadFileInFirebase.uploadFile(image)
                                    .then((url) {
                                  if (context.mounted) {
                                    context.read<ProfileCubit>().updateProfile(
                                          UserModel(
                                            id: widget.user.id,
                                            name: nameController.text,
                                            email: emailController.text,
                                            phoneNumber: phoneController.text,
                                            photoUrl: url,
                                          ),
                                        );
                                  }
                                });
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: const Icon(Icons.camera_alt,
                                size: 30, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: nameController,
                    hintText: "Name",
                    keyboardType: TextInputType.name,
                  ),

                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: statusController,
                    hintText: "Status",
                    keyboardType: TextInputType.text,
                  ),

                  // Text(user.email ?? ""),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProfileCubit>().updateProfile(
                                UserModel(
                                  id: widget.user.id,
                                  name: nameController.text,
                                  email: emailController.text,
                                  phoneNumber: phoneController.text,
                                  status: statusController.text,
                                  photoUrl: widget.user.photoUrl,
                                  lastSeen: widget.user.lastSeen,
                                ),
                              );
                        }
                      },
                      text: "Save"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
