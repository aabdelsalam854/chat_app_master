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
          final pickedFile = await SelectFileFromStorage.selectFiles();
          if (pickedFile != null && context.mounted) {
            await showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
            if (context.mounted) {
              GoRouter.of(context).push(
                Routes.kShowFileBeforeSend,
                extra: {'file': pickedFile, 'email': email},
              );
              Navigator.of(context).pop();
            }
          }
        },
        title: const Text(
          'file',
        ),
        leading: const Icon(Icons.file_copy),
      ),
    );
  }
}
