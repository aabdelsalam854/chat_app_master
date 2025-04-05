import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/utils/select_file_from_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class SelectFile extends StatelessWidget {
  const SelectFile({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          await SelectFileFromStorage.selectFiles().then((pickedFile) {
            if (pickedFile != null) {
              
              GoRouter.of(context).push(
                Routes.kShowFileBeforeSend,
                extra: ({'file': pickedFile, 'email': email}),
              );
            }
            Navigator.pop(context);
          });
        },
        title: const Text(
          'file',
        ),
        leading: const Icon(Icons.file_copy),
      ),
    );
  }
}

