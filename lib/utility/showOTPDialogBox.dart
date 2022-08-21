import 'package:flutter/material.dart';

void showOTPDialog(
    {required BuildContext context,
    required TextEditingController controller,
    required VoidCallback onpress}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter OTP'),
        content: TextField(
          controller: controller,
        ),
        actions: [TextButton(onPressed: onpress, child: const Text('Done'))],
      );
    },
  );
}
