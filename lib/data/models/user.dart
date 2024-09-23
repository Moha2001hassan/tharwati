import 'package:hive_flutter/hive_flutter.dart';

import 'counter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class MyUser {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final double dollarsNumber;

  @HiveField(5)
  final int diamondsNumber;

  @HiveField(6)
  final String? imageUrl;

  @HiveField(7)
  final List<String>? invitedIDs;

  @HiveField(8)
  final List<Counter>? userCounters;

  @HiveField(9)
  final double dailyIncome;

  MyUser({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.diamondsNumber,
    required this.dailyIncome,
    required this.dollarsNumber,
    this.imageUrl,
    this.invitedIDs,
    this.userCounters,
  });

  MyUser copyWith({
    String? userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    int? diamondsNumber,
    double? dailyIncome,
    double? dollarsNumber,
    String? imageUrl,
    List<String>? invitedIDs,
    List<Counter>? userCounters,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      diamondsNumber: diamondsNumber ?? this.diamondsNumber,
      dailyIncome: dailyIncome ?? this.dailyIncome,
      dollarsNumber: dollarsNumber ?? this.dollarsNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      invitedIDs: invitedIDs ?? this.invitedIDs,
      userCounters: userCounters ?? this.userCounters,
    );
  }

  // Convert User object to a map to save in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dollarsNumber': dollarsNumber,
      'diamondsNumber': diamondsNumber,
      'dailyIncome': dailyIncome,
      'imageUrl': imageUrl,
      'invitedIDs': invitedIDs ?? [],
      'userCounters':
      userCounters?.map((counter) => counter.toMap()).toList() ?? [],
    };
  }

  // Create a User object from a Firestore document snapshot
  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      userId: map['userId'],
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      diamondsNumber: map['diamondsNumber'],
      dailyIncome: map['dailyIncome'],
      dollarsNumber: map['dollarsNumber'],
      imageUrl: map['imageUrl'],
      invitedIDs: List<String>.from(map['invitedIDs'] ?? []),
      userCounters: (map['userCounters'] as List<dynamic>?)
          ?.map((counterMap) => Counter.fromMap(counterMap as Map<String, dynamic>))
          .toList(),
    );
  }
}
// flutter packages pub run build_runner build