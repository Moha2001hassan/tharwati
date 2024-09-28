import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> updateApprovedDepositRequest(
  String docId,
  String status,
  String userId,
  int dollarsAmount,
) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      int currentDiamonds = userDoc['diamondsNumber'] ?? 0;
      int updatedDiamonds = currentDiamonds + (dollarsAmount * 5000);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'diamondsNumber': updatedDiamonds});

      updateDepositRequestStatus(docId, status);
      debugPrint('Diamonds number updated successfully!');
    } else {
      debugPrint('User not found');
    }
  } catch (e) {
    debugPrint('Error updating approved request: $e');
  }
}

Future<void> updateDepositRequestStatus(String docId, String status) async {
  try {
    await FirebaseFirestore.instance
        .collection('deposits')
        .doc(docId)
        .update({'status': status});
  } catch (e) {
    debugPrint('Error updating request status: $e');
  }
}
Future<void> updateWithdrawRequestStatus(String docId, String status) async {
  try {
    await FirebaseFirestore.instance
        .collection('withdrawals')
        .doc(docId)
        .update({'status': status});
  } catch (e) {
    debugPrint('Error updating request status: $e');
  }
}

Stream<QuerySnapshot> getDepositRequests(String status) {
  return FirebaseFirestore.instance
      .collection('deposits')
      .where('status', isEqualTo: status)
      .snapshots();
}

Stream<QuerySnapshot> getWithdrawRequests(String status) {
  return FirebaseFirestore.instance
      .collection('withdrawals')
      .where('status', isEqualTo: status)
      .snapshots();
}

Future<void> deleteRequest(String docId) async {
  await FirebaseFirestore.instance.collection('deposits').doc(docId).delete();
}
