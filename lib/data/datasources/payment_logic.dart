import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../hive/hive_user_service.dart';
import 'user_firebase.dart';

class PaymentService {
  Future<void> submitDepositRequest({
    required XFile image,
    required int dollarsAmount,
    required int diamondsAmount,
    required int iraqiDinarAmount,
    required String invitationCode,
    required String userId,
    required bool isUSDT,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('payment_proofs')
        .child('$userId-$timestamp.jpg');

    await storageRef.putFile(File(image.path));
    final imageUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('deposits').add({
      'userId': userId,
      'invitationCode': invitationCode,
      'dollarsAmount': dollarsAmount,
      'diamondsAmount': diamondsAmount,
      'iraqiDinarAmount': iraqiDinarAmount,
      'proofImageUrl': imageUrl,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
      'isUSDT': isUSDT,
    });
  }

  Future<void> submitWithdrawalRequest({
    required String userId,
    required String invitationCode,
    required String wallet,
    required double dollarsAmount,
    required double iraqiDinarAmount,
    required bool isUSDT,
  }) async {
    await FirebaseFirestore.instance.collection('withdrawals').add({
      'userId': userId,
      'invitationCode': invitationCode,
      'isUSDT': isUSDT,
      'status': 'pending',
      'dollarsAmount': dollarsAmount,
      'wallet': wallet,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> submitPurchaseRequest({
    required BuildContext context,
    required XFile image,
    required int dollarsAmount,
    required int diamondsAmount,
    required int iraqiDinarAmount,
    required bool isUSDT,
  }) async {
    try {
      var userId = await getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('المستخدم غير موجود')),
        );
        return;
      }

      var user = await getUserData(userId);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('المستخدم غير موجود')),
        );
        return;
      }

      await PaymentService().submitDepositRequest(
        userId: userId,
        invitationCode: user.userId,
        image: image,
        dollarsAmount: dollarsAmount,
        diamondsAmount: diamondsAmount,
        iraqiDinarAmount: iraqiDinarAmount,
        isUSDT: isUSDT,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم ارسال طلب الايداع بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لقد فشلت عملية الايداع')),
      );
    }
  }
}

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Copied to clipboard!')),
  );
}
