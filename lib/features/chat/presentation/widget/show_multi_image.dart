import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/chat/presentation/widget/video_player.dart';
import 'package:flutter/material.dart';

class ShowMultiImage extends StatefulWidget {
  const ShowMultiImage({
    super.key,
    required this.imageFileNotifier,
  });
  final ValueNotifier<List<File>> imageFileNotifier;

  @override
  State<ShowMultiImage> createState() => _ShowMultiImageState();
}

class _ShowMultiImageState extends State<ShowMultiImage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    widget.imageFileNotifier.dispose();
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
            CarouselWidget(imageFileNotifier: widget.imageFileNotifier),

            // Bottom Image Previews with delete option
            BottomImagePreviews(imageFileNotifier: widget.imageFileNotifier),

            // Send Row with description input and send button
            SendRow(
              controller: controller,
              imageFileNotifier: widget.imageFileNotifier,
            ),
          ],
        ),
      ),
    );
  }
}

class FileWidget extends StatelessWidget {
  final File file;

  const FileWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final fileExtension = file.path.split('.').last;

    switch (fileExtension) {
      case 'jpg':
      case 'png':
      case 'jpeg':
        return Image.file(file);
      case 'mp4':
        return Expanded(
          child: VideoView(
            local: true,
            videoUrl: file,
          ),
        );
      default:
        return Image.file(file);
    }
  }
}

// Widget for displaying images and videos in a carousel
class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key, required this.imageFileNotifier});
  final ValueNotifier<List<File>> imageFileNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imageFileNotifier,
      builder: (context, value, child) => Expanded(
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.sizeOf(context).height,
                  viewportFraction: 1,
                  scrollPhysics: _getScrollPhysics(value)),
              items: List.generate(value.length, (index) {
                return FileWidget(file: value[index]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  ScrollPhysics _getScrollPhysics(List files) {
    return files.length == 1
        ? const NeverScrollableScrollPhysics()
        : const AlwaysScrollableScrollPhysics();
  }
}

// Widget for showing image previews and a delete button
class BottomImagePreviews extends StatelessWidget {
  const BottomImagePreviews({super.key, required this.imageFileNotifier});
  final ValueNotifier<List<File>> imageFileNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imageFileNotifier,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: value.length > 1
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        value.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              value.removeAt(index);
                              imageFileNotifier.value = List.from(value);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(value[index]),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                const Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete_forever_outlined,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

// Widget for the row containing the text field and send button
class SendRow extends StatelessWidget {
  const SendRow({
    super.key,
    required this.controller,
    required this.imageFileNotifier,
  });
  final TextEditingController controller;
  final ValueNotifier<List<File>> imageFileNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            await sl<ChatCubit>().sendFiles(
              files: imageFileNotifier.value,
              description: controller.text,
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
            );
            if (context.mounted) {
              Navigator.pop(context);
              controller.clear();
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
    );
  }
}
