import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

class DepositAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DepositAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'عمليات الايداع',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      foregroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.5),
      centerTitle: true,
      backgroundColor: MyColors.primary,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          labelColor: MyColors.primary,
          unselectedLabelColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          indicatorPadding: const EdgeInsets.symmetric(
            horizontal: -10,
            vertical: 5,
          ),
          tabs: const [
            Tab(text: 'معلقة'),
            Tab(text: 'مقبولة'),
            Tab(text: 'مرفوضة'),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // AppBar+TabBar height
}