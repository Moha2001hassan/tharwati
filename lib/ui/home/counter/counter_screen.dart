import 'package:flutter/material.dart';
import '../../../data/datasources/counter_firebase.dart';
import '../../../data/models/counter.dart';
import '../../shared_widgets/basic_appbar.dart';
import 'widgets/card_item_vertical.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: "العدادات"),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 5,
          bottom: 5,
        ),
        child: StreamBuilder<List<Counter>>(
          stream: getAllCounters(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching counters'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No counters available'));
            }

            List<Counter> counters = snapshot.data!;

            return SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.63, // Adjust as needed
                ),
                itemCount: counters.length,
                itemBuilder: (context, index) {
                  return CardItemVertical(counter: counters[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}



