import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    this.validator,
    required this.hintText,
    this.icon,
    this.onEditingComplete,
  });

  final TextEditingController passwordController;
  final String? Function(String?)? validator;
  final String hintText;
  final Widget? icon;
  final Function()? onEditingComplete;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> isShow = ValueNotifier<bool>(true);

  @override
  void dispose() {
    isShow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isShow,
      builder: (context, value, child) {
        return CustomTextFormField(
          hintText: widget.hintText,
          controller: widget.passwordController,
          obscureText: value,
          keyboardType: TextInputType.visiblePassword,
          onEditingComplete: widget.onEditingComplete,
          icon: PasswordToggleIcon(isShow: isShow),
          validator: widget.validator,
        );
      },
    );
  }
}

class PasswordToggleIcon extends StatelessWidget {
  final ValueNotifier<bool> isShow;
  const PasswordToggleIcon({super.key, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isShow,
      builder: (context, value, child) {
        return IconButton(
          icon: Icon(value ? Icons.visibility_off : Icons.visibility),
          onPressed: () => isShow.value = !isShow.value,
        );
      },
    );
  }
}
