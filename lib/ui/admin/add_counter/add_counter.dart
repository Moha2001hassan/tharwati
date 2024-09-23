import 'dart:io';
import 'package:flutter/material.dart';
import '../../shared_widgets/basic_appbar.dart';
import 'widgets/add_counter_form.dart';
import 'widgets/add_counter_header.dart';

class AddCounterScreen extends StatefulWidget {
  const AddCounterScreen({super.key});

  @override
  State<AddCounterScreen> createState() => _AddCounterScreenState();
}

class _AddCounterScreenState extends State<AddCounterScreen> {
  File? _selectedImage;

  void _handleImagePicked(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: "Add Counter"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Add counter image
              AddCounterHeader(onImagePicked: _handleImagePicked),
              const SizedBox(height: 20),

              // Form
              AddCounterForm(selectedImage: _selectedImage),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
