import 'package:flutter/material.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/routing/routes.dart';

class BottomNavContainer extends StatelessWidget {
  const BottomNavContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MaterialButton(
              elevation: 10,
              onPressed: () => context.pushNamed(Routes.counterScreen),
              height: double.infinity,
              child: Image.asset(MyImages.counterIcon, height: 30),
            ),
          ),
          Expanded(
            child: MaterialButton(
              height: double.infinity,
              onPressed: () => context.pushNamed(Routes.walletScreen),
              child: Image.asset(MyImages.walletIcon, height: 30),
            ),
          ),
          // Expanded(
          //   child: MaterialButton(
          //     onPressed: () => context.pushNamed(Routes.audioRoomScreen),
          //     height: double.infinity,
          //     child: Image.asset(MyImages.audioRoomIcon, height: 30),
          //   ),
          // ),
          Expanded(
            child: MaterialButton(
              onPressed: () => context.pushNamed(Routes.profileScreen),
              height: double.infinity,
              child: Image.asset(MyImages.boyImg, height: 30),
            ),
          ),
        ],
      ),
    );
  }
}