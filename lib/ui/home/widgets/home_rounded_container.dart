import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';

class HomeRoundedContainer extends StatelessWidget {
  const HomeRoundedContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.onIconPressed,
  });

  final String text;
  final IconData icon;
  final Future<void> Function()? onIconPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 20),
      decoration: BoxDecoration(
        color: onIconPressed != null ? MyColors.primary : MyColors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onIconPressed,
            icon: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          const Text(
            MyTexts.activeCounter,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
