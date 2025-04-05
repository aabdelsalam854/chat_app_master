import 'dart:io';

import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/chat/presentation/views/chat_views.dart';
import 'package:chat_master/features/chat/presentation/views/widget/show_file_and_send.dart';
import 'package:chat_master/features/chat/presentation/views/widget/show_multi_image.dart';
import 'package:chat_master/features/home/presentation/pages/home_page.dart';

import 'package:chat_master/features/login/presentation/views/register.dart';
import 'package:file_picker/file_picker.dart';

import 'package:go_router/go_router.dart';

import 'package:chat_master/features/chat/presentation/views/widget/show_image.dart';
import 'package:chat_master/features/chat/presentation/views/widget/show_image_and_send.dart';

import 'package:chat_master/features/chat/presentation/views/widget/video_player.dart';

abstract class AppRouts {
  static final router = GoRouter(routes: [
    GoRoute(
      path: Routes.kLogin,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: Routes.kRegisterView,
      builder: (context, state) => const RegisterViews(),
    ),
    GoRoute(
      path: Routes.kChatView,
      builder: (context, state) {
        return ChatView(
          state.extra as String,
        );
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
          email: data['email'] as String,
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
  ]);
}
