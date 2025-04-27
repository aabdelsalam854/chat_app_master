import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/widget/app_bottom_sheet.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/data/model/metadata_model.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/record/audio_recorder_view/audio_recorder_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class SendMessage extends StatefulWidget {
  const SendMessage({
    super.key,
    this.controller,
    required this.email,
    required this.type,
    required this.message,
    required this.metadata,
    this.isGroup = false,
  });

  final TextEditingController? controller;
  final String email;
  final String type;
  final String message;
  final MetadataModel? metadata;
  final bool? isGroup;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  late final ValueNotifier<String> _messageNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _messageNotifier.value = widget.controller!.text;
      widget.controller?.addListener(() {
        _messageNotifier.value = widget.controller!.text;
      });
    }
  }

  @override
  void dispose() {
    _messageNotifier.dispose();
    super.dispose();
  }

  Future<void> _sendInGroupMessage(
    String message,
    BuildContext context,
  ) async {
    await context.read<ChatCubit>().sendGroupMessage(
          groupId: "2yjWS9lmdJ6T6qnULVfJ",
          message: MessageModel(
            message: message,
            id: widget.email,
            type: "text",
            metadata: widget.metadata,
            time: DateTime.now(),
          ),
        );

    widget.controller?.clear();
    _messageNotifier.value = '';
  }

  Future<void> _sendMessage(
    String message,
    BuildContext context,
  ) async {
    await context.read<ChatCubit>().sendMessage(
          message: MessageModel(
            
            message: message,
            id: widget.email,
            type: "text",
            metadata: widget.metadata,
            time: DateTime.now(),
          ),
          userId1: kUid,
          userId2: widget.email,
          user1: UserModel(
            email: kUid,
            name: "kName",
            photoUrl: "kPhotoUrl",
            id: kUid,
          ),
          user2: UserModel(
            email: widget.email,
            name: "kName",
            photoUrl: "kPhotoUrl",
            id: widget.email,
          ),
        );

    widget.controller?.clear();
    _messageNotifier.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _messageNotifier,
      builder: (context, value, child) {
        return IconButton(
          onPressed: () async {
            if (value.isEmpty) {
              showAppBottomSheet(context, builder: (context) {
                return const AudioRecorderView();
              });
              return;
            }

            if (widget.isGroup ?? false) {
              await _sendInGroupMessage(value, context);
            } else {
              await _sendMessage(value, context);
            }
          },
          icon: Icon(
            value.isEmpty ? Icons.mic : Icons.send,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
