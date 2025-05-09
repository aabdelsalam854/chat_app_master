import 'package:chat_master/core/constant/cached_key.dart';
import 'package:chat_master/core/encryption/encryption.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/core/widget/custom_circle_network_image.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_state.dart';
import 'package:chat_master/features/profile/presentation/widgets/switch_theme_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = sl<SharedPreferences>().getString(CachedKey.uid) ?? '';
    final encryptedUid = uid.decrypt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      // floatingActionButton: FloatingActionButton(
      body: SettingsViewBody(
        uid: encryptedUid!,
      ),
    );
  }
}

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetUserDataSuccessState ||
          current is GetUserDataLoadingState ||
          current is GetUserDataErrorState,
      bloc: context.read<ProfileCubit>()..getUserData(uid),
      builder: (context, state) {
        if (state is GetUserDataSuccessState) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => GoRouter.of(context)
                            .push(Routes.kProfile, extra: state.userModel),
                        child: Row(children: [
                          SizedBox(
                              height: 90,
                              child: Hero(
                                tag: state.userModel.photoUrl ?? "",
                                child: CustomCircleNetworkImage(
                                    imageUrl: state.userModel.photoUrl ?? ""),
                              )),
                          const SizedBox(width: 16),
                          Column(children: [
                            Text(
                              state.userModel.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(state.userModel.status!,
                                style: const TextStyle(
                                  color: Colors.black,
                                ))
                          ])
                        ]),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        height: 32,
                      ),
                      ListTile(
                          onTap: () {
                            GoRouter.of(context).push(Routes.kChangePassword);
                          },
                          leading: const Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          title: const Text('Change Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),
                      const ListTile(
                          trailing: SwitchThemeIcon(),
                          title: Text('Theme',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),
                      const ListTile(
                          trailing: LanguageSwitch(),
                          title: Text('language',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),
                      CustomButton(
                          onPressed: () =>
                              FirebaseAuth.instance.signOut().then((v) {
                                sl<SharedPreferences>().remove(CachedKey.uid);
                                if (context.mounted) {
                                  GoRouter.of(context).go(Routes.kLogin);
                                }
                              }),
                          text: 'Logout')
                    ],
                  )),
                ),
              )
              // Add more widgets here as needed
            ],
          );
        } else if (state is GetUserDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserDataErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
