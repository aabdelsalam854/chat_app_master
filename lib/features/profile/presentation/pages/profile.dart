import 'package:chat_master/core/constant/cached_key.dart';
import 'package:chat_master/core/encryption/encryption.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/Profile/presentation/cubit/Profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final uid =  sl<SharedPreferences>().getString(CachedKey.uid) ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocProvider.value(
        value: sl<ProfileCubit>()..getUserData(uid.decrypt as String ),
        child: ProfileViewBody(),
      ),
    );
  }
}

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomButton(onPressed: () {}, text: "text")
          ],
        ),
      ),
    );
  }
}
