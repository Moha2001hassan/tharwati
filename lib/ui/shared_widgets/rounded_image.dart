import 'dart:io';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    required this.imgUrl,
    this.width = 390,
    this.height = 160,
    this.backgroundColor = MyColors.light,
    this.borderRadius = 10,
    this.applyImgRadius = true,
    this.isNetworkImage = false,
    this.isFileImage = false,
    this.fit = BoxFit.contain,
    this.padding,
    this.border,
    this.onPressed,
  });

  final double? width, height;
  final String? imgUrl;
  final bool applyImgRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final bool isFileImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          color: backgroundColor,
        ),
        child: ClipRRect(
          borderRadius: applyImgRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            fit: fit,
            image: _getImageProvider(),
            errorBuilder: (context, error, stackTrace) {
              return const Image(
                image: AssetImage(MyImages.noImageFound),
                fit: BoxFit.contain,
              );
            },
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider() {
    if (imgUrl == null || imgUrl!.isEmpty) {
      return const AssetImage(MyImages.noImageFound);
    }

    if (isNetworkImage) {
      return NetworkImage(imgUrl!);
    } else if (isFileImage) {
      return FileImage(File(imgUrl!));
    } else {
      return AssetImage(imgUrl!);
    }
  }
}

