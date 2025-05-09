import 'dart:io';

import 'package:chat_master/core/widget/custom_button.dart';
import 'package:flutter/material.dart';


class ShowImageAndSend extends StatelessWidget {
  const ShowImageAndSend({
    super.key,
    required this.email,
    required this.imageFromGallery,
  });

  final String email;
  final File imageFromGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Image(
                fit: BoxFit.cover,
                image: FileImage(imageFromGallery),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              text: 'Send',
              onPressed: () async {
                Navigator.pop(context);

                // final upDateurl = await UploadFileInFirebase.uploadFile(
                //     File(imageFromGallery.path));
                // final file = File(imageFromGallery.path);
                // final fileSize = await file.length();
                // final bytes = await file.readAsBytes();
                // final image = img.decodeImage(bytes);

                // await FireCloud.sendMessage(
                //   MessageModel(
                //       message: upDateurl,
                //       id: email,
                //       type: 'image',
                //       time: DateTime.now(),
                //       metadata: MetadataModel(
                //         details: null,
                //         fileType: null,
                //         fileName:
                //             imageFromGallery.path.split('/').last, // اسم الملف
                //         fileSize: fileSize.toString(), // حجم الملف
                //         width: image!.width, // عرض الصورة
                //         height: image.height, // ارتفاع الصورة
                //       )),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
