import 'dart:io';
import 'dart:async';
import 'package:chat_master/core/enums/media_type.dart';
import 'package:chat_master/features/app/presentation/cubits/app/app_cubit.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

// Get Platform
String get getPlatform => Platform.operatingSystem;
// Get Current App Language
String get appLang => currentLangCode;

bool get isArabic => currentLangCode == 'ar';
bool get isEnglish => currentLangCode == 'en';

Future<String> get fcmToken async => 'fcmToken';

// Future<String> get fcmToken async =>
//     await FirebaseMessaging.instance.getToken() ?? 'fcmToken';

String parseDate(String date) =>
    DateFormat('yyyy-MM-dd').format(DateTime.parse(date));

String parseDateTime(String date) =>
    DateFormat('yyyy-MM-dd').add_jm().format(DateTime.parse(date));

String parseTime(String date) =>
    DateFormat('hh:mm a').format(DateTime.parse(date));

Future<XFile?> pickImage(ImageSource source) async =>
    await ImagePicker().pickImage(source: source);

Future<List<XFile>?> pickMultiImage() async =>
    await ImagePicker().pickMultiImage();

String generateChatId(String firstUserId, String secondUserId) {
  final sortedIds = <String>[firstUserId, secondUserId]..sort();
  return sortedIds.join('_');
}
  String getFolderName(MediaType type) {
    switch (type) {
      case MediaType.image:
        return 'images';
      case MediaType.audio:
        return 'audio';
      case MediaType.video:
        return 'videos';
      case MediaType.document:
        return 'documents';
    }
  }
  String getFileType(String path) {
  final extension = path.split('.').last.toLowerCase();

  if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
    return 'image';
  } else if (['mp4', 'mov', 'avi', 'mkv'].contains(extension)) {
    return 'video';
  } else if (['mp3', 'wav', 'aac', 'ogg', 'm4a'].contains(extension)) {
    return 'record';
  } else if (['pdf', 'doc', 'docx', 'xls', 'xlsx'].contains(extension)) {
    return 'document';
  } else {
    return 'unknown';
  }
}
