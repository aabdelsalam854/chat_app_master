import 'package:chat_master/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

Future<T?> showAppBottomSheet<T>(BuildContext context,
    {required Widget Function(BuildContext) builder,
    bool? enableDrag,
    bool showCloseButton = false}) async {
  return await showModalBottomSheet<T?>(
    context: context,
    // backgroundColor: AppColors.success,
    isDismissible: false,
    enableDrag: enableDrag ?? false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
    ),
    builder: (context) {
      return PopScope(
        canPop: true,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCloseButton)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              builder(context)
            ],
          ),
        ),
      );
    },
  );
}
