import 'package:flutter/material.dart';

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({super.key, this.image, this.diamonds, this.dollars});

  final String? dollars, image, diamonds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image!, height: 22, width: 22),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              (diamonds == null) ? "$dollars" : "$diamonds",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
