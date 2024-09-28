import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/datasources/counter_firebase.dart';
import '../../../../data/datasources/user_firebase.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../shared_widgets/rounded_image.dart';

class ProfileHeader extends StatefulWidget {

  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _image;
  String? _imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }
  Future<void> _pickImage() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        // Upload the image to Firebase Storage
        String imageUrl = await uploadImageToStorage(_image!);

        // Update the user's profile in Firestore with the new image URL
        await updateUserProfile(imageUrl);

        // Update the local state to reflect the new image URL
        setState(() {
          _imageUrl = imageUrl;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Storage permission is required to pick images')),
      );
    }
  }

  Future<void> _fetchUserData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Fetch the user's data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId) // Replace 'userId' with the actual user ID
          .get();

      if (userSnapshot.exists) {
        setState(() {
          _imageUrl = userSnapshot['imageUrl'] as String?;
          _isLoading = false;
        });
      } else {
        debugPrint('User does not exist in Firestore.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isLoading
            ? const CircularProgressIndicator()
            : RoundedImage(
          imgUrl: _image != null
              ? _image!.path
              : _imageUrl ?? MyImages.boyImg,
          isNetworkImage: _image == null && _imageUrl != null,
          height: 100,
          width: 100,
          borderRadius: 100,
          backgroundColor: Colors.lightBlue,
          padding: const EdgeInsets.all(2),
          fit: BoxFit.cover,
          border: Border.all(color: Colors.black),
        ),
        // TextButton(
        //   onPressed: _pickImage,
        //   child: const Text(
        //     MyTexts.changeProfilePic,
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
      ],
    );
  }
}
