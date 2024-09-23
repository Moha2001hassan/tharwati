import 'package:flutter/material.dart';

class BalanceRow extends StatelessWidget {
  const BalanceRow({
    super.key,
    required this.balance,
    required this.bgColor,
    required this.icon,
  });

  final String balance, icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            balance,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Image.asset(icon, height: 30, width: 30),
        ],
      ),
    );
  }
}
