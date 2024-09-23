import 'dart:math';
import '../../data/datasources/user_firebase.dart';

Future<String> generateUniqueUserId() async {
  final random = Random();
  int userId;
  bool exists;

  do {
    userId = random.nextInt(900000) + 100000;
    exists = await checkUserIdExists(userId);
  } while (exists);

  return userId.toString();
}