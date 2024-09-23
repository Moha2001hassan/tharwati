import 'package:flutter/material.dart';

class WalletTextForm extends StatelessWidget {
  const WalletTextForm({
    super.key,
    required TextEditingController walletController,
    this.isUSDT = true,
  }) : _walletController = walletController;

  final TextEditingController _walletController;
  final bool isUSDT;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _walletController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: isUSDT ? 'MasterCard - ادخل محفظة' : 'Zain Cash - ادخل محفظة',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'يجب ادخال المحفظة';
          }
          return null;
        },
      ),
    );
  }
}
