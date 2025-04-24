import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/extensions/media_query.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/data/model/metadata_model.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShowMultiImage extends StatefulWidget {
  const ShowMultiImage({
    super.key,
    required this.file,
  });

  final List<File> file;

  @override
  State<ShowMultiImage> createState() => _ShowMultiImageState();
}

class _ShowMultiImageState extends State<ShowMultiImage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: MediaQuery.sizeOf(context).height,
                        viewportFraction: 1,
                        scrollPhysics: widget.file.length == 1
                            ? const NeverScrollableScrollPhysics()
                            : null),
                    items: widget.file.map((files) {
                      switch (files.path.split('.').last) {
                        case 'jpg':
                        case 'png':
                        case 'jpeg':
                          return Image.file(files);

                        default:
                          return Image.file(files);
                      }
                    }).toList(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.file.length > 1
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Row(
                                        children: List.generate(
                                            widget.file.length, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              widget.file.removeAt(index);
                                              setState(() {});
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file[index]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                const Positioned.fill(
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons
                                                              .delete_forever_outlined,
                                                          size: 50,
                                                          color: Colors.grey,
                                                        ))),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    for (final file in widget.file) {
                      final imageUrl =
                          await UploadFileInFirebase.uploadFile(file);

                      final extension = file.path.split('.').last.toLowerCase();
                      final isVideo = extension == 'mp4';
                      final fileType = isVideo ? 'video' : 'image';

                      await sl<ChatCubit>().sendMessage(
                          user1: UserModel(
                            email: kUid,
                            name: "kName",
                            photoUrl: "kPhotoUrl",
                            id: kUid,
                          ),
                          user2: const UserModel(
                            email: "ZBsU7iXYmaT46Xz58QXp1D8IDz02",
                            name: "kName",
                            photoUrl: "kPhotoUrl",
                            id: "ZBsU7iXYmaT46Xz58QXp1D8IDz02",
                          ),
                          userId1: kUid,
                          userId2: "ZBsU7iXYmaT46Xz58QXp1D8IDz02",
                          message: MessageModel(
                            message: imageUrl,
                            id: kUid,
                            type: fileType,
                            time: DateTime.now(),
                            metadata: MetadataModel(
                              width: 0,
                              height: 0,
                              details: controller.text,
                              fileSize: file.lengthSync().toString(),
                              fileType: fileType,
                              fileName: file.path.split('/').last,
                            ),
                          ));
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: controller,
                    hintText: 'Type a description',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
