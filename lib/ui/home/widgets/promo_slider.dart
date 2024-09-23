import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import '../../../../utils/constants/colors.dart';
import '../../shared_widgets/circular_container.dart';
import '../../shared_widgets/rounded_image.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key, required this.banners});

  final List<String> banners;

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        const SizedBox(height: 15),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(() => _currentIndex = index);
        },
        autoPlay: true, // Enable auto play
        autoPlayInterval: const Duration(seconds: 6), // Change every 7 seconds
        autoPlayAnimationDuration: const Duration(milliseconds: 600), // Optional: control animation speed
        autoPlayCurve: Curves.fastOutSlowIn, // Optional: adjust curve for smooth transition
      ),
      items: widget.banners
          .map((url) => RoundedImage(imgUrl: url, fit: BoxFit.cover, width: 320, isNetworkImage: true))
          .toList(),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.banners.length, (index) {
        return CircularContainer(
          width: 18,
          height: 4,
          margin: const EdgeInsets.only(right: 10),
          backgroundColor: _currentIndex == index ? MyColors.primary : Colors.grey,
        );
      }),
    );
  }
}

