import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool enabled;

  const AppTextField({
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kcMediumGrey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kcPrimaryColor),
        ),
      ),
    );
  }
}
