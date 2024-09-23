import 'package:flutter/material.dart';
import '../../../shared_widgets/rounded_image.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onTap,
  });

  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      color: Colors.grey.shade500,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              RoundedImage(
                imgUrl: imageAsset,
                applyImgRadius: true,
                backgroundColor: Colors.white,
                fit: BoxFit.contain,
                border: Border.all(color: Colors.grey.shade500),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}