import 'package:chat_master/core/constant/bloc_observer.dart';
import 'package:chat_master/core/styles/app_theme.dart';
import 'package:chat_master/core/styles/cubit/theme_cubit.dart';
import 'package:chat_master/core/routes/app_router.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/responsive_widget.dart';
import 'package:chat_master/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  Bloc.observer = const MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setUpServerLocator();

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        // BlocProvider(
        //     create: (context) =>
        //         LoginAndRegisterCubit(sl.get<LoginAndRegisterRepoImpl>())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          if (themeState is ThemeChanged) {
            return Responsive(
              child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: appThemeData[themeState.appTheme]!,
                  routerConfig: AppRouts.router),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
