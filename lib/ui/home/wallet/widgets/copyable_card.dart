import 'package:flutter/material.dart';

import '../../../../data/datasources/payment_logic.dart';

class CopyableCard extends StatelessWidget {
  final String wallet;

  const CopyableCard({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'المحفظة المراد ارسال الاموال عليها',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () => copyToClipboard(context, wallet),
                  tooltip: 'Copy to clipboard',
                ),
                Flexible(
                  child: Text(
                    wallet,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}