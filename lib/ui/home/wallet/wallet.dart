import 'package:flutter/material.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../data/datasources/user_firebase.dart';
import '../../../data/hive/hive_user_service.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/routing/routes.dart';
import '../../shared_widgets/basic_appbar.dart';
import '../../shared_widgets/custom_button.dart';
import 'widgets/balance_row.dart';
import 'widgets/daily_income_container.dart';
import 'widgets/payment_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String? _selectedButton;
  // Colors
  final Color selectedColor = MyColors.primary;
  final Color unselectedColor = Colors.grey;

  int _diamondsNumber = 0;
  double _dailyIncome = 0;
  double _dollarsNumber = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      var userId = await getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to retrieve user ID.')),
        );
        return;
      }
      var userData = await getUser(userId);
      if (userData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to retrieve user data.')),
        );
        return;
      }
      setState(() {
        _diamondsNumber = userData['diamondsNumber'] ?? 0;
        _dollarsNumber = userData['dollarsNumber'] ?? 0;
        _dailyIncome = userData['dailyIncome'] ?? 0;
      });
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to retrieve diamonds number.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: "المحفظة"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Balance
              const Text(
                MyTexts.yourBalance,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              // Dollars Number
              BalanceRow(
                balance: _dollarsNumber.toStringAsFixed(6),
                bgColor: Colors.green.shade200,
                icon: MyImages.dollarIcon,
              ),
              const SizedBox(height: 10),
              BalanceRow(
                balance: _diamondsNumber.toString(),
                bgColor: Colors.blue.shade100,
                icon: MyImages.diamondIcon,
              ),
              const SizedBox(height: 10),

              // Daily Income
              const Text(
                MyTexts.dailyIncome,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              DailyIncomeContainer(dailyIncomeDiamonds: '$_dailyIncome'),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "الايداع",
                      fontSize: 20,
                      color: _selectedButton == "الايداع"
                          ? selectedColor
                          : unselectedColor,
                      onTap: () {
                        setState(() => _selectedButton = 'الايداع');
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      text: "السحب",
                      fontSize: 20,
                      color: _selectedButton == "السحب"
                          ? selectedColor
                          : unselectedColor,
                      onTap: () {
                        setState(() => _selectedButton = 'السحب');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (_selectedButton != null)
                Text(
                  'اكمل عملية $_selectedButton بستخدام ',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 10),

              // USDT
              if (_selectedButton != null)
                PaymentCard(
                  onTap: () {
                    if (_selectedButton == 'الايداع') {
                      context.pushNamed(Routes.usdtDepositScreen);
                    }
                    if (_selectedButton == 'السحب') {
                      context.pushNamed(
                        Routes.userWithdrawScreen,
                        arguments: true,
                      );
                    }
                  },
                  title: 'MasterCard',
                  imageAsset: MyImages.masterCardImage,
                ),
              const SizedBox(height: 10),

              // Zain Cash
              if (_selectedButton != null)
                PaymentCard(
                  onTap: () {
                    if (_selectedButton == 'الايداع') {
                      context.pushNamed(Routes.zainCashDepositScreen);
                    }
                    if (_selectedButton == 'السحب') {
                      context.pushNamed(
                        Routes.userWithdrawScreen,
                        arguments: false,
                      );
                    }
                  },
                  title: 'Zain Cash',
                  imageAsset: MyImages.zainCashImg,
                ),
              const SizedBox(height: 10),

              // Key Card
              if (_selectedButton != null)
                Stack(
                  children: [
                    PaymentCard(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('قريبا')),
                        );
                      },
                      title: 'Key Card',
                      imageAsset: MyImages.keyCardImg,
                    ),
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: const Text(
                          'سيتوفر قريبا',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
