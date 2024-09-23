import 'package:flutter/material.dart';

import '../../shared_widgets/basic_appbar.dart';

class AudioRoomScreen extends StatelessWidget {
  const AudioRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(title: "Audio Room"),
        body: Center(
          child: Text("Audio Room"),
        ),
      ),
    );
  }
}
