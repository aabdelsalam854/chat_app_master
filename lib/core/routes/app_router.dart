import 'dart:io';
import 'package:chat_master/core/constant/cached_key.dart';
import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/encryption/encryption.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat_master/features/auth/presentation/views/forget_password.dart';
import 'package:chat_master/features/chat/presentation/pages/chat_views.dart';
import 'package:chat_master/features/chat/presentation/widget/show_file_and_send.dart';
import 'package:chat_master/features/chat/presentation/widget/show_multi_image.dart';
import 'package:chat_master/features/auth/presentation/views/login_view.dart';
import 'package:chat_master/features/auth/presentation/views/register.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/pages/start_chat.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chat_master/features/profile/presentation/pages/change_password.dart';
import 'package:chat_master/features/profile/presentation/pages/profile_view.dart';
import 'package:chat_master/features/profile/presentation/pages/settings.dart';
import 'package:chat_master/home/presentation/views/user_main_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_master/features/chat/presentation/widget/show_image.dart';
import 'package:chat_master/features/chat/presentation/widget/show_image_and_send.dart';
import 'package:chat_master/features/chat/presentation/widget/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRouts {
  static final router = GoRouter(routes: [
    GoRoute(
        path: Routes.kLogin,
        builder: (context, state) {
          if (sl<SharedPreferences>().getString(CachedKey.uid) != null) {
            kUid = sl<SharedPreferences>().getString(CachedKey.uid)!.decrypt()!;

            return BlocProvider.value(
              value: sl<AuthCubit>(),
              child: const MainScreen(),
            );
          } else {
            return BlocProvider.value(
              value: sl<AuthCubit>(),
              child: const LoginViews(),
            );
          }
        }),
    GoRoute(
        path: Routes.kRegisterView,
        builder: (context, state) => BlocProvider.value(
            value: sl<AuthCubit>(), child: const RegisterViews())),
    GoRoute(
        path: Routes.kHome,
        builder: (context, state) {
          return const MainScreen();
        }),
    GoRoute(
      path: Routes.kChatView,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return ChatView(
            email: data['email'] as String,
            name: data['name'] as String,
            photoUrl: data['photoUrl'] as String?,
            uid: data['id'] as String);
      },
    ),
    GoRoute(
      path: Routes.kShowFileBeforeSend,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return ShowFileBeforeSend(
          pickedFile: data['file'] as PlatformFile,
          email: data['email'] as String,
        );
      },
    ),
    GoRoute(
      path: Routes.kShowImage,
      builder: (context, state) {
        final data = state.extra as String;
        return ShowImage(
          message: data,
        );
      },
    ),
    GoRoute(
      path: Routes.kMediaSelection,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ShowMultiImage(
          file: data['imageFile'] as List<File>,
        
        );
      },
    ),
    GoRoute(
      path: Routes.kVideoPlayer,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return VideoView(
          local: data['isFile'] as bool,
          videoUrl: data['message'] as String,
        );
      },
    ),
    GoRoute(
      path: Routes.kShowImageAndSend,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ShowImageAndSend(
          email: data['email'] as String,
          imageFromGallery: data['imageFile'] as File,
        );
      },
    ),
    GoRoute(
        path: Routes.kForgetPassword,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<AuthCubit>(),
            child: const ForgetPassword(),
          );
        }),
    GoRoute(
      path: Routes.kSettings,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<AuthCubit>(),
          child: const SettingsView(),
        );
      },
    ),
    GoRoute(
      path: Routes.kChangePassword,
      builder: (context, state) {
        return const ChangePassword();
      },
    ),
    GoRoute(
        path: Routes.kProfile,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<ProfileCubit>(),
            child: ProfileView(
              user: state.extra as UserModel,
            ),
          );
        }),
    GoRoute(
        path: Routes.kStartChat,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<HomeCubit>(),
            child: const StartChat(),
          );
        })
  ]);
}
