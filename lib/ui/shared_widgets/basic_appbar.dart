import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      foregroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.5),
      centerTitle: true,
      backgroundColor: MyColors.primary,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(56);
}