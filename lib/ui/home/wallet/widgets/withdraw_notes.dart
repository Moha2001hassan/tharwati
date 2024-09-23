import 'package:flutter/material.dart';

class WithdrawNotes extends StatelessWidget {
  const WithdrawNotes({super.key, this.isUSDT = true});

  final bool isUSDT;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // if (!isUSDT)
              //   const Text(
              //     'سعر الدولار مقابل الدينار العراقي: 1500',
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.w900,
              //     ),
              //   ),
              Text(
                'الحد الادني للسحب 10 دولار',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'سيتم خصم 0% رسوم السحب',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
