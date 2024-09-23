import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackArrow,
      backgroundColor: MyColors.primary,
      foregroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.5),
      centerTitle: true,
      title: title,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: leadingOnPressed,
          child: Image.asset(
            MyImages.dollarsLogo, // Replace with your asset path
            width: 40.0, // Customize size if needed
            height: 40.0,
          ),
        ),
      ),
      // actions: const [
      //   Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 10.0),
      //     child: NotificationCounterIcon(iconColor: Colors.white),
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
