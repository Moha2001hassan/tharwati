import 'package:flutter/material.dart';
import '../../../../data/datasources/user_firebase.dart';
import '../../../../data/hive/hive_user_service.dart';
import '../../../../data/models/counter.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/show_snack_bar.dart';

void showCounterDialog({
  required BuildContext context,
  required Counter counter,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CounterDialog(counter: counter);
    },
  );
}

class CounterDialog extends StatelessWidget {
  const CounterDialog({super.key, required this.counter});

  final Counter counter;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  counter.title,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Divider(),
          // Price
          _buildInfoRow('${counter.price} \$', MyTexts.counterPrice),
          const SizedBox(height: 4),
          // Income
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(MyImages.dollarAnimation, height: 22),
              const SizedBox(width: 10),
              _buildInfoRow('${counter.dailyIncome.toDouble()}', MyTexts.dailyIncome),
            ],
          ),
          const SizedBox(height: 4),
          _buildInfoRow('${counter.monthsNumber}', MyTexts.monthsNumber),
          const SizedBox(height: 4),
          _buildInfoRow('${counter.buysNumber}', MyTexts.counterBuyTimes),
        ],
      ),
      actions: [
        _buildCancelButton(context),
        _buildBuyButton(context, counter),
      ],
    );
  }

  Widget _buildInfoRow(String value, String label) {
    return Text(
      '$value :$label',
      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return MaterialButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text(
        MyTexts.cancel,
        style: TextStyle(
          fontSize: 15,
          color: Colors.pink,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context, Counter counter) {
    return MaterialButton(
      color: MyColors.primary,
      onPressed: () => _handleBuyCounter(context, counter),
      child: const Text(
        MyTexts.buyCounter,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Future<void> _handleBuyCounter(BuildContext context, Counter counter) async {
    _showLoadingDialog(context);
    try {
      String? userId = await getUserId();
      if (userId != null) {
        await buyCounter(userId, counter, context);
        Navigator.of(context).pop(); // Close CounterDialog
      } else {
        showSnackBar('No user found in Hive.', Colors.red, context);
      }
    } catch (e) {
      showSnackBar('Error updating userCounters: $e', Colors.red, context);
    }
  }



  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
