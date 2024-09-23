import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color = MyColors.primary,
    this.onTap,
    this.showBorder = false,
    this.fontSize = 16,
    this.textColor = Colors.white,
  });

  final String text;
  final double fontSize;
  final Color? color, textColor;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: showBorder
                ? Border.all()
                : Border.all(color: Colors.transparent),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
