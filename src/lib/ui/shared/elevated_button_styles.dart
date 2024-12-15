import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class ElevatedButtonStyles {
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: kcPrimaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: kcSecondaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ButtonStyle outlinedButton = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: kcPrimaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: kcPrimaryColor),
    ),
  );
}
