import 'package:flutter/material.dart';

Future<bool> showBoolDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required String cancelButtonText,
}) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            actions: [
              MaterialButton(
                color: Colors.red,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelButtonText,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  confirmButtonText,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}
