import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class DailyIncomeContainer extends StatelessWidget {
  const DailyIncomeContainer({super.key, required this.dailyIncomeDiamonds});

  final String dailyIncomeDiamonds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.primary.withOpacity(0.7),
        border: Border.all(color: MyColors.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dailyIncomeDiamonds,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}