import 'package:flutter/material.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../shared_widgets/show_bool_dialog.dart';

class WithdrawCard extends StatelessWidget {
  final double dollarsAmount;
  final String userId;
  final String invitationCode;
  final String wallet;
  final String status;
  final bool isUSDT;
  final VoidCallback onApprove;
  final VoidCallback onDelete;

  const WithdrawCard({
    super.key,
    required this.dollarsAmount,
    required this.userId,
    required this.invitationCode,
    required this.status,
    required this.onApprove,
    required this.onDelete,
    required this.isUSDT,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white70,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                isUSDT ? MyImages.usdtImage : MyImages.zainCashImg,
                width: double.infinity, // Full width
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // wallet
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: SelectableText(
                        wallet,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      ":المحفظة",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                // texts
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'دولار',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$dollarsAmount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      ":مبلغ السحب",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

                // invitation code
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectableText(
                      invitationCode,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      ":رمز الدعوه",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // buttons
                if (status == 'pending')
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool shouldApprove = await showBoolDialog(
                          context: context,
                          title: 'تأكيد الموافقه',
                          content: 'هل تود تاكيد الموافقه؟',
                          confirmButtonText: 'Yes',
                          cancelButtonText: 'No',
                        );
                        if (shouldApprove) {
                          onApprove();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('موافق'),
                    ),
                  ),

                if (status == 'approved')
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool shouldDelete = await showBoolDialog(
                          context: context,
                          title: 'تحذير الحذف',
                          content: 'هل تود حذف هذا الايداع؟',
                          confirmButtonText: 'Yes',
                          cancelButtonText: 'No',
                        );
                        if (shouldDelete) {
                          onDelete();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('حذف'),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
