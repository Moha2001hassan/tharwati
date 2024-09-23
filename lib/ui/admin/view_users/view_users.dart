import 'package:flutter/material.dart';

import '../../shared_widgets/basic_appbar.dart';

class ViewUsersScreen extends StatelessWidget {
  const ViewUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppBar(title: "Users"),
    );
  }
}
