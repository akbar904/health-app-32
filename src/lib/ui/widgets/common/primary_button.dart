import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool busy;
  final bool enabled;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.busy = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? kcPrimaryColor : kcLightGrey,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: enabled && !busy ? onPressed : null,
      child: busy
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }
}
