import 'package:chat_master/config/locale/app_localizations_setup.dart';
import 'package:chat_master/core/constant/bloc_observer.dart';
import 'package:chat_master/core/styles/app_theme.dart';
import 'package:chat_master/core/routes/app_router.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/utils/app_constants.dart';
import 'package:chat_master/core/widget/responsive_widget.dart';
import 'package:chat_master/features/app/presentation/cubits/app/app_cubit.dart';
import 'package:chat_master/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = const MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setUpServerLocator();

  // await sl<AppCubit>().getSavedLang();
  // await sl<AppCubit>().getSavedTheme();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AppCubit>()
        ..getSavedLang()
        ..getSavedTheme(),
      child: Responsive(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, themeState) {
            return MaterialApp.router(
                scaffoldMessengerKey: AppConstants.scaffoldKey,
                // locale: Locale("en"),
                supportedLocales: AppLocalSetup.supportedLocales,
                localizationsDelegates: AppLocalSetup.localizationsDelegates,
                localeResolutionCallback:
                    AppLocalSetup.localeResolutionCallback,
                debugShowCheckedModeBanner: false,
                theme: appThemeData[themeState.appTheme]!,
                routerConfig: AppRouts.router);
          },
        ),
      ),
    );
  }
}
