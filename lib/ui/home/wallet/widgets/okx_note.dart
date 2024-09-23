import 'package:flutter/material.dart';

class OKXNote extends StatelessWidget {
  const OKXNote({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            'لا نستقبل الايداع من محافظ غير مركزية ننصح باستخدام محفضة\n OKX.',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}