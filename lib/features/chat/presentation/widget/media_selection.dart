import 'dart:io';
import 'package:camera/camera.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/utils/cam.dart';
import 'package:chat_master/features/chat/presentation/widget/cam.dart';
import 'package:chat_master/features/chat/presentation/widget/selcet_file.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MediaSelection extends StatelessWidget {
  const MediaSelection({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        color: Colors.black26,
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () async {
                  await availableCameras().then((value) {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CameraWidget(email: email, cameras: value)),
                      );
                    }
                  });
                },
                title: const Text('camera'),
                leading: const Icon(Icons.camera),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  // ImagePickerHelper.selectMedia().then((mediaSelect) {
                  //   if (mediaSelect != null) {
                  //     List<File> imageFile =
                  //         mediaSelect.map((media) => File(media.path)).toList();


                  //     if (context.mounted) {

                  //       GoRouter.of(context).push(Routes.kMediaSelection,
                  //           extra: ({'imageFile': imageFile, 'email': email}));
                  //     }
                  //   }
                  // });
                  SelectMediaFromStorage.selectMedia().then((mediaSelect) {
                    if (mediaSelect != null) {
                      List<File> imageFile = mediaSelect
                          .map((media) => File(media.path!))
                          .toList();
                      if (context.mounted) {
                        GoRouter.of(context).push(Routes.kMediaSelection,
                            extra: ({'imageFile': imageFile, 'email': email}));
                      }
                    }
                  });
                },
                title: const Text('Select Media'),
                leading: const Icon(Icons.camera),
              ),
            ),
            SelectFile(email: email),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
