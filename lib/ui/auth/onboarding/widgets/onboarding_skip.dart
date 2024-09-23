import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final Function onSkip;

  const SkipButton({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: TextButton(
          onPressed: () => onSkip(),
          child: const Text(
            "تخطي",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          )),
    );
  }
}
