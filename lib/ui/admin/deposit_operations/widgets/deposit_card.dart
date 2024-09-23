import 'package:flutter/material.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../shared_widgets/open_image_viewer.dart';
import '../../../shared_widgets/show_bool_dialog.dart';

class DepositCard extends StatelessWidget {
  final String imageUrl;
  final int dollarsAmount;
  final int iraqiDinarAmount;
  final String userId;
  final String invitationCode;
  final String status;
  final bool isUSDT;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback onDelete;
  final VoidCallback onUndoReject;

  const DepositCard({
    super.key,
    required this.imageUrl,
    required this.dollarsAmount,
    required this.iraqiDinarAmount,
    required this.userId,
    required this.invitationCode,
    required this.status,
    required this.onApprove,
    required this.onReject,
    required this.onDelete,
    required this.onUndoReject,
    required this.isUSDT,
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
          GestureDetector(
            onTap: () => openImageViewer(context, imageUrl),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity, // Full width
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // image & texts
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      isUSDT ? MyImages.usdtImage : MyImages.zainCashImg,
                      width: 35,
                      height: 35,
                    ),
                    const Spacer(),
                    Text(
                      isUSDT ? 'دولار' : 'دينار عراقي',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isUSDT ? '$dollarsAmount' : '$iraqiDinarAmount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      ":مبلغ الايداع",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 120,
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
                      SizedBox(
                        width: 120,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool shouldReject = await showBoolDialog(
                              context: context,
                              title: 'تأكيد الرفض',
                              content: 'هل تود تاكيد الرفض؟',
                              confirmButtonText: 'Yes',
                              cancelButtonText: 'No',
                            );
                            if (shouldReject) {
                              onReject();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('رفض'),
                        ),
                      ),
                    ],
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

                if (status == 'rejected')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 44,
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
                      SizedBox(
                        width: 120,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool shouldUndoReject = await showBoolDialog(
                              context: context,
                              title: 'تراجع الرفض',
                              content: 'هل تود ان تتراجع عن الرفض؟',
                              confirmButtonText: 'Yes',
                              cancelButtonText: 'No',
                            );
                            if (shouldUndoReject) {
                              onUndoReject();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('تراجع'),
                        ),
                      ),
                    ],
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
