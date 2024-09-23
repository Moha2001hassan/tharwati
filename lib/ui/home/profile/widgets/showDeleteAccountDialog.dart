import 'package:flutter/material.dart';

void showDeleteAccountDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmText,
  required String cancelText,
  required Function(String password) onConfirm,
}) {
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: true, // Allow closing by tapping outside the dialog
    builder: (BuildContext context) {
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
            const SizedBox(height: 20),
            // TextField to enter the password
            TextField(
              controller: passwordController,
              obscureText: true, // Hide the password text
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
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
              onConfirm(passwordController.text);
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
    },
  );
}
