import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class CardStyles {
  static BoxDecoration defaultCardDecoration = BoxDecoration(
    color: kcSurfaceWhite,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: kcShadowColor,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration elevatedCardDecoration = BoxDecoration(
    color: kcSurfaceWhite,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: kcShadowColor,
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration flatCardDecoration = BoxDecoration(
    color: kcSurfaceWhite,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: kcLightGrey),
  );
}
