import 'dart:io';
import 'package:chat_master/core/utils/get_file_size.dart';
import 'package:chat_master/features/chat/data/model/metadata_model.dart';
import 'package:chat_master/features/chat/presentation/widget/build_file_widget.dart';
import 'package:chat_master/features/chat/presentation/widget/send_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/upload_file_in_firebase.dart';

class ShowFileBeforeSend extends StatelessWidget {
  const ShowFileBeforeSend({
    super.key,
    this.pickedFile,
    this.email,
  });
  final PlatformFile? pickedFile;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pickedFile!.extension!),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: BuildFileWidget(file: pickedFile),
          ),
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                final url = await UploadFileInFirebase.uploadFile(
                    File(pickedFile!.path!));

                SendMessage(
                    message: url,
                    email: email!,
                    type: 'File',
                    metadata: MetadataModel(
                      fileName: pickedFile!.name,
                      details: null,
                      fileSize: GetFileSize.getFileSize(pickedFile!.size),
                      fileType: pickedFile!.extension!,
                      height: null,
                      width: null,
                    ));
              },
              child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(
                    Icons.send,
                    size: 30,
                  )),
            ),
          )
        ]));
  }
}
