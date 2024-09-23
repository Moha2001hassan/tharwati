import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/datasources/payment_logic.dart';
import '../../../../utils/helpers/screen_util.dart';
import '../../../shared_widgets/basic_appbar.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/show_bool_dialog.dart';
import '../widgets/copyable_card.dart';
import '../widgets/dinars_count_card.dart';

class USDTDepositScreen extends StatefulWidget {
  const USDTDepositScreen({super.key});

  @override
  State<USDTDepositScreen> createState() => _USDTDepositScreenState();
}

class _USDTDepositScreenState extends State<USDTDepositScreen> {
  final _picker = ImagePicker();
  XFile? _image;
  int _dollarsAmount = 10;
  int _iraqiDinarAmount = 15000;
  bool _isLoading = false;
  bool isMasterCard = true;
  //String usdtWallet = 'TQj5PVfLmku7yMfy3XczL8KwADHWpYzKE2';
  String masterCardWallet = '2730999063';

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() => _image = pickedImage);
  }

  void _updateDiamondsAmount() {
    setState(() {
      _iraqiDinarAmount = (_dollarsAmount * 1500).round();
    });
  }

  Future<void> _submitPurchaseRequest() async {
    setState(() => _isLoading = true);
    await PaymentService().submitPurchaseRequest(
      context: context,
      image: _image!,
      dollarsAmount: _dollarsAmount,
      diamondsAmount: 0,
      iraqiDinarAmount: _iraqiDinarAmount,
      isUSDT: true,
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: "MasterCard ايداع"),
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "اجراء عملية الايداع عن طريق",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Mastercard",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<int>(
                    dropdownColor: Colors.green[100],
                    value: _dollarsAmount,
                    onChanged: (newValue) {
                      setState(() {
                        _dollarsAmount = newValue!;
                        _updateDiamondsAmount();
                      });
                    },
                    items: [10, 25, 50, 100, 200, 300, 500, 1000]
                        .map((amount) => DropdownMenuItem(
                            value: amount, child: Text('$amount \$')))
                        .toList(),
                  ),
                  const Text(
                    ':اختر المبلغ المراد ايداعه',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              // Diamonds
              const SizedBox(height: 20),
              DinarCountCard(iraqDinarAmount: _iraqiDinarAmount),
              const SizedBox(height: 10),

              CopyableCard(wallet: masterCardWallet),
              const SizedBox(height: 20),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text(
                  'اختر صورة الايداع',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _pickImage,
              ),
              if (_image != null) Image.file(File(_image!.path), height: 100),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'تقديم طلب الايداع',
                      onTap: () async {
                        if (_image == null) return;
                        bool confirm = await showBoolDialog(
                          context: context,
                          title: 'تأكيد عملية الايداع',
                          content: 'هل أنت متأكد من تقديم عملية الايداع؟',
                          confirmButtonText: 'تأكيد',
                          cancelButtonText: 'إلغاء',
                        );
                        if (confirm) {
                          _submitPurchaseRequest();
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

