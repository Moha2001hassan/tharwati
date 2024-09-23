import 'package:flutter/material.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmText,
  required String cancelText,
  required Function onConfirm,
}) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allow closing by tapping outside the dialog
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        body: body,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
      );
    },
  );
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.body,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
  });

  final String title;
  final String body;
  final String confirmText;
  final String cancelText;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const Divider(),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            cancelText,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.pink,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        MaterialButton(
          color: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            confirmText,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

