import 'dart:io';
import 'dart:async';
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
