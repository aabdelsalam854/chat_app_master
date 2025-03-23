import 'package:chat_master/core/constant/bloc_observer.dart';
import 'package:chat_master/core/utils/app_router.dart';
import 'package:chat_master/core/utils/server_locator.dart';
import 'package:chat_master/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/login/data/repo/login_and_register_repo_impl.dart';
import 'features/login/presentation/manger/cubit/login_and_register_cubit.dart';

void main() async {
  Bloc.observer = const MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // await CacheData.cacheInitialization();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUpServerLocator();
  // kToken = CacheData.getData(key: 'token');

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                LoginAndRegisterCubit(getit.get<LoginAndRegisterRepoImpl>())),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ).copyWith(
            scaffoldBackgroundColor: Color(0xFF222530),
          ),
            
          routerConfig: AppRouts.router),
    );
  }
}
