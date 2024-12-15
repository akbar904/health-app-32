import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

const double _tinySize = 4;
const double _smallSize = 8;
const double _mediumSize = 16;
const double _largeSize = 24;
const double _massiveSize = 32;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    Divider(color: kcLightGrey, thickness: 1),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);
Widget horizontalSpace(double width) => SizedBox(width: width);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

EdgeInsets screenPadding(BuildContext context) =>
    MediaQuery.of(context).padding;

Widget errorMessageWidget(String message) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: kcErrorRed.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kcErrorRed.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        const Icon(Icons.error_outline, color: kcErrorRed, size: 20),
        horizontalSpaceSmall,
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: kcErrorRed,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget successMessageWidget(String message) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: kcSuccessGreen.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kcSuccessGreen.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        const Icon(Icons.check_circle_outline, color: kcSuccessGreen, size: 20),
        horizontalSpaceSmall,
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: kcSuccessGreen,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
