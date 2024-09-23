import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import '../../utils/constants/keys.dart';
import '../../utils/helpers/show_snack_bar.dart';
import '../models/counter.dart';
import '../models/user.dart';

Future<bool> checkUserIdExists(int userId) async {
  QuerySnapshot query = await FirebaseFirestore.instance
      .collection(MyKeys.users)
      .where(MyKeys.userId, isEqualTo: userId)
      .limit(1)
      .get();

  return query.docs.isNotEmpty;
}

Future<void> saveUserData(User? user, Map<String, dynamic> userData) async {
  if (user != null) {
    await FirebaseFirestore.instance
        .collection(MyKeys.users)
        .doc(user.uid)
        .set(userData);
  }
}

Future<Map<String, dynamic>?> getUser(String userId) async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection(MyKeys.users)
      .doc(userId)
      .get();
  return userDoc.data() as Map<String, dynamic>?;
}

Future<MyUser?> getUserData(String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection(MyKeys.users)
            .doc(userId)
            .get();

    if (snapshot.exists && snapshot.data() != null) {
      return MyUser.fromMap(snapshot.data()!);
    } else {
      return null; // User does not exist
    }
  } catch (e) {
    print('Error getting user data: $e');
    return null;
  }
}

Future<void> updateUserProfile(String imageUrl) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection(MyKeys.users).doc(userId).update({
      MyKeys.imageUrl: imageUrl,
    });
  } catch (e) {
    print('Error getting user data: $e');
    return;
  }
}

Future<void> updateUserDiamondsDollars(int diamondsNumber, double dollarsNumber) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection(MyKeys.users).doc(userId).update({
     // MyKeys.diamondsNumber: diamondsNumber,
      MyKeys.dollarsNumber: dollarsNumber,
    });
  } catch (e) {
    print('Error getting user data: $e');
    return;
  }
}

Future<void> checkCountersAvailability() async {
  double updatedDailyIncome = 0.0001;
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    MyUser? user = await getUserData(userId);

    if (user != null) {
      List<Counter>? userCounters = user.userCounters;
      if (userCounters != null && userCounters.isNotEmpty) {
        final DateTime currentTime = await NTP.now();
        for (Counter counter in userCounters) {
          if (counter.expireDate.isAfter(currentTime)) {
            updatedDailyIncome += counter.dailyIncome;
            counter.isAvailable = true;
            print('Counter ${counter.title} is available');
          } else {
            counter.isAvailable = false;
            print('Counter ${counter.title} is not available');
          }
        }
      }
      // Update the dailyIncome field in Firestore
      await FirebaseFirestore.instance.collection(MyKeys.users).doc(userId).update({
        MyKeys.dailyIncome: updatedDailyIncome,
        MyKeys.userCounters: userCounters?.map((c) => c.toMap()).toList() ?? [],
      });
    }
    print('User data updated successfully');
  } catch (e) {
    print('Error getting user data: $e');
    return;
  }
}

Future<void> buyCounter(String userId, Counter counter, BuildContext context) async {
  if (counter.buysNumber > 0) {
    try {
      // Get the user's current data
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final MyUser user = MyUser.fromMap(userDoc.data() as Map<String, dynamic>);

      final double requiredDollars = counter.price;
      if (user.dollarsNumber >= requiredDollars) {
        counter.buysNumber--;
        counter.isAvailable = true; // Set the isAvailable parameter to true

        // Update dailyIncomeDiamonds
        final double newDailyIncome = user.dailyIncome + counter.dailyIncome;

        // Update the userCounters list
        final updatedCounters = user.userCounters ?? [];
        updatedCounters.add(counter);

        // Save the updated user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'dailyIncome': newDailyIncome,
          'dollarsNumber': user.dollarsNumber - requiredDollars,
          'userCounters': updatedCounters.map((c) => c.toMap()).toList(),
        });

        showSnackBar('تم الشراء بنجاح', Colors.green, context);
      } else {
        showSnackBar('رصيتك غير كافية', Colors.red, context);
      }
    } catch (e) {
      showSnackBar('حدث خطأ حاول لاحقا', Colors.red, context);
    }
  } else {
    showSnackBar('استنفذت عدد مرات شراء التطبيق', Colors.red, context);
  }
}
