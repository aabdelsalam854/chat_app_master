import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.onTap,
    this.keyboardType,
    this.icon,
    this.validator,
    this.maxLines,
    this.readOnly = false,
    this.enabled,
    this.expands = false,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.onSaved,
  });

  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? icon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool readOnly;
  final bool? enabled;
  final bool expands;
  final int? maxLength;
  final TextAlign textAlign;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
          textInputAction:
              TextInputAction.done, 

          onSaved: onSaved,
          validator: validator ??
              (data) {
                if (data!.isEmpty) {
                  return 'يجب ملء هذا الحقل';
                }
                return null;
              },
          maxLength: maxLength,
          buildCounter: (_,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) {
            return null;
          },
          textAlign: textAlign,
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: icon,
            labelText: hintText,
          )),
    );
  }
}
