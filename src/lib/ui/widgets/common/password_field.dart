import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class AppPasswordField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;

  const AppPasswordField({
    required this.labelText,
    required this.controller,
    this.validator,
    this.enabled = true,
    super.key,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      enabled: widget.enabled,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kcMediumGrey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kcPrimaryColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: kcMediumGrey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
