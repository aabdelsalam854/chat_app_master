import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_master/core/fire_cloud/fire_cloud.dart';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/chat/presentation/views/widget/chat_bubble_friend.dart';
import 'package:chat_master/features/chat/presentation/views/widget/chat_puple.dart';
import 'package:chat_master/features/chat/presentation/views/widget/media_selection.dart';
import 'package:chat_master/features/chat/presentation/views/widget/send_message.dart';
import 'package:chat_master/features/chat/presentation/views/widget/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:shimmer/shimmer.dart';
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
  }

  @override
  void dispose() {
    textController.dispose();
    controller.dispose();

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
    await FireCloud.sendMessage(
      MessageModel(
        metadata: null,
        message: url,
        id: widget.uid,
        time: DateTime.now(),
        type: 'MessageType.record',
      ),
    );

    // stopwatch.reset();
    log('File uploaded to $url');
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

  void dipose() {
    record.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatsAppBar(
        context,
        image: widget.photoUrl,
        name: widget.name,
      ),
      body: StreamBuilder(
        stream: ChatService()
            .getMessages(
              "chatId",
              "chatId",
            )
            .asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = snapshot.data!;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == widget.email
                              ? ChatBubble(
                                  messageModel: messagesList[index],
                                  message: messagesList[index].message,
                                )
                              : ChatBubbleFriend(
                                  message: messagesList[index].message,
                                  messageModel: messagesList[index]);
                        },
                        itemCount: messagesList.length,
                      ),
                    ),
                    Row(
                      children: [
                        SendMeaasge(
                            metadata: null,
                            type: 'MessageType.text',
                            message: textController.text,
                            controller: textController,
                            email: widget.uid),
                        // isEmpty
                        //     ? recorder(context)
                        //     : SendMeaasge(
                        //         metadata: null,
                        //         type: 'MessageType.text',
                        //         message: textController.text,
                        //         controller: textController,
                        //         email: widget.email),
                        Expanded(
                          child: CustomTextFormField(
                            icon: IconButton(
                              onPressed: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MediaSelection(email: widget.email);
                                  },
                                );
                              },
                              icon: const Icon(Icons.add),
                            ),
                            controller: textController,
                            hintText: 'Type a message',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Loading');
          }
        },
      ),
    );
  }

  AppBar chatsAppBar(BuildContext context, {String? name, String? image}) {
    return AppBar(
      backgroundColor: Colors.grey,
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.back,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: image == null
                  ? Image.asset("assets/images/facebook.png",
                      width: 40, height: 40, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/facebook.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
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
