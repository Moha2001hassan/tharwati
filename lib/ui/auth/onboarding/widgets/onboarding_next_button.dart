import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class OnBoardingNextButton extends StatelessWidget {
  final Function onNext;

  const OnBoardingNextButton({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      right: 25,
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          onPressed: () => onNext(),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary,
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Iconsax.arrow_right_3,
            color: Colors.white,
            //size: 30,
          ),
        ),
      ),
    );
  }
}
