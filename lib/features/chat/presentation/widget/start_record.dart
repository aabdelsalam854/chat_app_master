import 'dart:io';

import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/features/chat/presentation/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    record = AudioRecorder();
  }

  bool isRecording = false;
  bool isEmpty = true;

  late AudioRecorder record;
  final timeController = TimeController();

  void startRecord() async {
    final location = await getApplicationDocumentsDirectory();
    final name = const Uuid().v1();
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(),
          path: '${location.path}/$name.m4a');
    }
    timeController.startTimer();
    debugPrint('start record');
  }

  void stopRecord() async {
    final finalPath = await record.stop();
    setState(() {
      isRecording = false;
    });
    timeController.stopTimer();
    final url = await UploadFileInFirebase.uploadFile(File(finalPath!));

    debugPrint(finalPath);
    debugPrint('stop Record');
  }

  void resumeRecord() async {
    await record.resume();
    timeController.resumeTimer();

    debugPrint('resumeRecord');
  }

  void pauseRecord() async {
    await record.pause();
    timeController.pauseTimer();
    debugPrint('pauseRecord');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            startRecord();
                            setState(() {
                              isRecording = true;
                            });
                            if (isRecording = true) {
                            } else {
                              timeController.stopTimer();
                            }
                          },
                          icon: const Icon(Icons.mic)),
                      IconButton(
                          onPressed: () {
                            pauseRecord();
                          },
                          icon: const Icon(Icons.pause)),
                      IconButton(
                          onPressed: () {
                            resumeRecord();
                          },
                          icon: const Icon(Icons.play_arrow)),
                      IconButton(
                          onPressed: () {
                            stopRecord();
                            setState(() {
                              isRecording = false;
                            });
                          },
                          icon: const Icon(Icons.stop)),
                      TimerWidget(
                        controller: timeController,
                      ),
                    ],
                  ),
                );
              });
        },
        child: isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic));
  }
}
