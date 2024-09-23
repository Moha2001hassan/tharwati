import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCounterHeader extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;
  const AddCounterHeader({super.key, required this.onImagePicked});
  @override
  State<AddCounterHeader> createState() => _AddCounterHeaderState();
}

class _AddCounterHeaderState extends State<AddCounterHeader> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImagePicked(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: _selectedImage != null
              ? Image.file(
                  _selectedImage!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 150,
                  width: 150,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        const Text("Tap to select an image"),
      ],
    );
  }
}
