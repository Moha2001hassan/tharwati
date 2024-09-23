import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ntp/ntp.dart';

part 'counter.g.dart';

@HiveType(typeId: 1)
class Counter {
  @HiveField(0)
  String title;

  @HiveField(1)
  double price;

  @HiveField(2)
  double dailyIncome;

  @HiveField(3)
  int monthsNumber;

  @HiveField(4)
  int buysNumber;

  @HiveField(5)
  bool isAvailable;

  @HiveField(6)
  DateTime expireDate;

  @HiveField(7)
  String? imageUrl;

  Counter({
    required this.title,
    required this.price,
    required this.dailyIncome,
    required this.monthsNumber,
    required this.buysNumber,
    required this.expireDate,
    this.isAvailable = false,
    this.imageUrl,
  });

  Future<void> updateExpireDate() async {
    final DateTime networkTime = await NTP.now();
    expireDate = networkTime.add(Duration(days: monthsNumber * 30));
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'dailyIncome': dailyIncome,
      'monthsNumber': monthsNumber,
      'buysNumber': buysNumber,
      'isAvailable': isAvailable,
      'expireDate': Timestamp.fromDate(expireDate),
      'imageUrl': imageUrl,
    };
  }

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      title: map['title'],
      price: (map['price'] as num).toDouble(),
      dailyIncome:(map['dailyIncome'] as num).toDouble(),
      monthsNumber: map['monthsNumber'],
      buysNumber: map['buysNumber'],
      isAvailable: map['isAvailable'],
      expireDate: (map['expireDate'] as Timestamp).toDate(),
      imageUrl: map['imageUrl'],
    );
  }
}
