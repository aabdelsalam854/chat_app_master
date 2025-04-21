import 'dart:io';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/features/chat/presentation/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class WhatsAppStyleRecorder extends StatefulWidget {
  const WhatsAppStyleRecorder({super.key});

  @override
  State<WhatsAppStyleRecorder> createState() => _WhatsAppStyleRecorderState();
}

class _WhatsAppStyleRecorderState extends State<WhatsAppStyleRecorder> {
  late AudioRecorder record;
  final timeController = TimeController();

  Offset _startOffset = Offset.zero;
  bool isRecording = false;
  bool isCancelled = false;
  String? recordedPath;

  @override
  void initState() {
    super.initState();
    record = AudioRecorder();
  }

  Future<void> startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    final name = const Uuid().v1();
    final path = '${dir.path}/$name.m4a';

    if (await record.hasPermission()) {
      await record.start(const RecordConfig(), path: path);
      setState(() {
        isRecording = true;
        isCancelled = false;
        recordedPath = path;
      });
      timeController.startTimer();
    }
  }

  Future<void> stopRecording() async {
    await record.stop();
    timeController.stopTimer();
    setState(() => isRecording = false);

    if (!isCancelled && recordedPath != null) {
      final url = await UploadFileInFirebase.uploadFile(File(recordedPath!));
      debugPrint('Uploaded: $url');
    }
  }

  void cancelRecording() {
    record.stop();
    timeController.stopTimer();
    setState(() {
      isRecording = false;
      isCancelled = true;
    });
    debugPrint('Recording cancelled');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // alignment: Alignment.bottomLeft,
      children: [
        if (isRecording)
          Positioned(
            left: 16,
            bottom: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.mic, color: Colors.white),
                  const SizedBox(width: 8),
                  TimerWidget(controller: timeController),
                  const SizedBox(width: 16),
                  const Text("Slide left to cancel",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
          ),
        GestureDetector(
          onLongPressStart: (_) {
            _startOffset = _.globalPosition;
            startRecording();
          },
          onLongPressMoveUpdate: (details) {
            final delta = details.globalPosition.dx - _startOffset.dx;
            if (delta < -100) {
              cancelRecording();
            }
          },
          onLongPressEnd: (_) => stopRecording(),
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isRecording ? Colors.red : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mic, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }
}
