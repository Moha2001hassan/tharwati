import 'package:flutter/material.dart';

class WhoUsScreen extends StatelessWidget {
  const WhoUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T-shirt Shop'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          Text("Hi"),
        ],
      ),
    );
  }
}
