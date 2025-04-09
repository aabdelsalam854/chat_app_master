import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/profile/presentation/widgets/switch_theme_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      // floatingActionButton: FloatingActionButton(
      body: SettingsViewBody(),
    );
  }
}

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
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
                Row(children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 16),
                  Column(children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('@johndoe',
                        style: TextStyle(
                          color: Colors.black,
                        ))
                  ])
                ]),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  height: 32,
                ),
                ListTile(
                    onTap: () {
                      GoRouter.of(context).push(Routes.kProfile);
                    },
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: Text('Edit Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ))),
                ListTile(
                    trailing: SwitchThemeIcon(),
                    title: Text('Theme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ))),
                ListTile(
                    trailing: LanguageSwitch(),
                    title: Text('language',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ))),
              ],
            )),
          ),
        )
        // Add more widgets here as needed
      ],
    );
  }
}
