import 'dart:developer';
import 'dart:io';
import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_app_bar.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_body.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_bubble_friend.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_bubble.dart';
import 'package:chat_master/features/chat/presentation/widget/media_selection.dart';
import 'package:chat_master/features/chat/presentation/widget/send_message.dart';
import 'package:chat_master/features/chat/presentation/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class ChatView extends StatefulWidget {
  final String email;
  final String uid;
  final String? name;
  final String? photoUrl;

  const ChatView(
      {super.key,
      required this.email,
      required this.uid,
      this.name,
      this.photoUrl});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController textController = TextEditingController();

  bool isRecording = false;
  bool isEmpty = true;
  final controller = ScrollController();
  late AudioRecorder record;
  final timeController = TimeController();

  @override
  void initState() {
    super.initState();
    record = AudioRecorder();
    log(kUid);
    log(widget.uid);
  }

  @override
  void dispose() {
    textController.dispose();
    controller.dispose();
    record.dispose();

    super.dispose();
  }

  // _controller() {
  //   controller.animateTo(0,
  //       duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  // }

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
    // await FireCloud.sendMessage(
    //   MessageModel(
    //     metadata: null,
    //     message: url,
    //     id: widget.uid,
    //     time: DateTime.now(),
    //     type: 'MessageType.record',
    //   ),
    // );

    // stopwatch.reset();

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
    return Scaffold(
        appBar: chatsAppBar(
          context,
          image: widget.photoUrl,
          name: widget.name,
        ),
        body: BlocProvider(
          create: (context) =>
              sl<ChatCubit>()..getMessages(userId1: kUid, userId2: widget.uid),
          child: ChatBody(
              widget: widget,
              controller: controller,
              textController: textController),
        ));
  }

  GestureDetector recorder(BuildContext context) {
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

