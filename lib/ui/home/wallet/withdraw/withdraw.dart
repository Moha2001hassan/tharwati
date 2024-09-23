import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../data/datasources/payment_logic.dart';
import '../../../../data/datasources/user_firebase.dart';
import '../../../../data/hive/hive_user_service.dart';
import '../../../../utils/constants/keys.dart';
import '../../../../utils/helpers/screen_util.dart';
import '../../../../utils/helpers/show_snack_bar.dart';
import '../../../shared_widgets/basic_appbar.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/show_bool_dialog.dart';
import '../widgets/iraqi_dinar_price.dart';
import '../widgets/wallet_text_form.dart';
import '../widgets/withdraw_notes.dart';

class UserWithdrawScreen extends StatefulWidget {
  final bool isUSDT;

  const UserWithdrawScreen({super.key, required this.isUSDT});

  @override
  State<UserWithdrawScreen> createState() => _UserWithdrawScreenState();
}

class _UserWithdrawScreenState extends State<UserWithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _walletController = TextEditingController();
  double _dollarsAmount = 0;
  double _afterTaxAmount = 0;
  double _iraqiDinar = 0;
  bool _isLoading = false;
  bool isUSDT = true;
  double? _dollarsNumber;

  @override
  void initState() {
    super.initState();
    isUSDT = widget.isUSDT;
    _amountController.text = _dollarsAmount.toString();
    _calculateAfterTaxAmount();
    _fetchUserDiamondsNumber();
  }

  void _calculateAfterTaxAmount() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    setState(() {
      //_afterTaxAmount = double.parse((amount - (amount * 0.18)).toStringAsFixed(3));
      _afterTaxAmount = amount;
      _iraqiDinar = double.parse((_afterTaxAmount * 1500).toStringAsFixed(3));
    });
  }

  Future<void> _fetchUserDiamondsNumber() async {
    try {
      var userId = await getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('المستخدم غير موجود')),
        );
        return;
      }
      var userData = await getUser(userId);
      if (userData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('بيانات المستخدم غير موجودة')),
        );
        return;
      }
      setState(() {
        _dollarsNumber = userData['dollarsNumber'] ?? 0.0;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('خطأ في الاتصال بالسيرفر')),
      );
    }
  }

  Future<void> _submitWithdrawalRequest() async {
    setState(() => _isLoading = true);
    try {
      var userId = await getUserId();
      if (userId == null) {
        showSnackBar('خطأ في الاتصال بالسيرفر', Colors.red, context);
        setState(() => _isLoading = false);
        return;
      }

      var user = await getUserData(userId);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('المستخدم غير موجود')),
        );
        setState(() => _isLoading = false);
        return;
      }

      if (_dollarsNumber! >= _dollarsAmount) {
        double newDollarsNumber = _dollarsNumber! - _dollarsAmount;
        await FirebaseFirestore.instance
            .collection(MyKeys.users)
            .doc(userId)
            .update({'dollarsNumber': newDollarsNumber});

        await PaymentService().submitWithdrawalRequest(
          userId: userId,
          invitationCode: user.userId,
          dollarsAmount: _afterTaxAmount.toDouble(),
          iraqiDinarAmount: _iraqiDinar,
          isUSDT: isUSDT,
          wallet: _walletController.text,
        );

        showSnackBar('تمت ارسال طلب السحب بنجاح.', Colors.green, context);
      } else {
        showSnackBar('رصيدك غير كافي للسحب.', Colors.red, context);
      }
    } catch (error) {
      showSnackBar('حدث خطأ في عملية السحب.', Colors.red, context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: isUSDT ? "MasterCard سحب" : "ZainCash سحب",
      ),
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "اجراء عملية السحب عن طريق",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  isUSDT ? "MasterCard" : "Zain Cash",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // withdrawal notes
                WithdrawNotes(isUSDT: isUSDT),
                const SizedBox(height: 20),

                // Enter dollars amount with TextFormField
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'ادخل المبلغ المراد سحبه',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(0),
                          ),
                          onChanged: (value) {
                            _dollarsAmount = double.tryParse(value) ?? 0;
                            _calculateAfterTaxAmount();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يجب ادخال المبلغ';
                            } else if (double.tryParse(value)! <= 9) {
                              return 'الحد الادنى للسحب هو 10 دولار';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'سوف يصلك',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$_afterTaxAmount',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                IraqiDinarPrice(iraqiDinar: _iraqiDinar),

                const SizedBox(height: 20),

                // Enter wallet string with TextFormField
                WalletTextForm(
                  walletController: _walletController,
                  isUSDT: isUSDT,
                ),
                //if (isUSDT) const OKXNote(),
                const SizedBox(height: 20),

                _isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'تقديم طلب السحب',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            bool confirm = await showBoolDialog(
                              context: context,
                              title: 'تأكيد طلب السحب',
                              content: 'هل أنت متأكد من تقديم طلب السحب؟',
                              confirmButtonText: 'تأكيد',
                              cancelButtonText: 'إلغاء',
                            );
                            if (confirm) {
                              _submitWithdrawalRequest();
                            }
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
