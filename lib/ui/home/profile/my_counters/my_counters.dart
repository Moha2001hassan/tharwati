import 'package:flutter/material.dart';
import '../../../../data/datasources/user_firebase.dart';
import '../../../../data/hive/hive_user_service.dart';
import '../../../../data/models/counter.dart';
import '../../../../data/models/user.dart';
import '../../../shared_widgets/basic_appbar.dart';
import 'widgets/card_item_horizontal.dart';

class MyCountersScreen extends StatelessWidget {
  const MyCountersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: "العدادات الخاصة بك"),
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching user ID'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user ID found'));
          } else {
            // Use the retrieved userId to fetch user data
            String userId = snapshot.data!;
            return FutureBuilder<MyUser?>(
              future: getUserData(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching user data'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('بيانات المستخدم غير متاحة'));
                } else {
                  // Extract user data
                  MyUser user = snapshot.data!;
                  List<Counter>? counters = user.userCounters?? [];

                  if(counters.isEmpty) {
                    return const Center(child: Text('لا توجد عدادات'));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: counters.length,
                      itemBuilder: (context, index) {
                        Counter counter = counters[index];
                        return CardItemHorizontal(counter: counter);
                      },
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
