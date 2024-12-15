import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

class ErrorSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const ErrorSheet({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.error_outline,
            color: Colors.red[700],
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            request.title ?? 'Error',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kcDarkGreyColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            request.description ?? 'An error occurred',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: kcMediumGrey,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => completer(SheetResponse(confirmed: true)),
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
