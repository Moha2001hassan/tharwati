import 'package:flutter/material.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../utils/helpers/screen_util.dart';
import '../../../utils/routing/routes.dart';
import '../shared_widgets/basic_appbar.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: "Admin"),
      body: Container(
        padding: const EdgeInsets.all(12),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  // Users
                  Expanded(
                    flex: 11,
                    child: AdminSectionBtn(
                      text: "المستخدمون",
                      color: Colors.blue,
                      onPressed: () => context.pushNamed(Routes.viewUserScreen),
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  // Add Counter
                  Expanded(
                    flex: 11,
                    child: AdminSectionBtn(
                      text: "اضافة عداد",
                      onPressed: () => context.pushNamed(Routes.addCounterScreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  // Counters
                  Expanded(
                    flex: 11,
                    child: AdminSectionBtn(
                      text: "العدادات",
                      color: Colors.orange,
                      onPressed: () => context.pushNamed(Routes.counterScreen),
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  // Banner Ads
                  Expanded(
                    flex: 11,
                    child: AdminSectionBtn(
                      text: "اعلانات البانر",
                      onPressed: () {
                        context.pushNamed(Routes.bannerAdsScreen);
                      },
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  // Withdrawals
                  Expanded(
                    flex: 11,
                    child: AdminSectionBtn(
                      text: "عمليات السحب",
                      color: Colors.deepPurple,
                      onPressed: () {
                        context.pushNamed(Routes.withdrawalsScreen);
                      },
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  // Deposit Operations
                  Expanded(
                    flex: 11,
                    child: AdminSectionBtn(
                      text: "عمليات الايداع",
                      onPressed: () => context.pushNamed(Routes.depositScreen),
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminSectionBtn extends StatelessWidget {
  const AdminSectionBtn({
    super.key,
    this.color = Colors.red,
    this.text = '',
    required this.onPressed,
  });

  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                shadows: [Shadow(color: Colors.black54, offset: Offset(1, 1))],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
