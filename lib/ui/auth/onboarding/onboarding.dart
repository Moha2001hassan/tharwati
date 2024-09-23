import 'package:flutter/material.dart';
import 'package:tharwati/utils/helpers/navigation.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/routing/routes.dart';
import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Horizontal Scrollable Pages
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {currentPage = index;});
              },
              children: const [
                OnBoardingPage(
                    image: MyImages.onboarding1,
                    title: MyTexts.onBoardingTitle1,
                    subtitle: MyTexts.onBoardingSubTitle1),
                OnBoardingPage(
                    image: MyImages.onboarding2,
                    title: MyTexts.onBoardingTitle2,
                    subtitle: MyTexts.onBoardingSubTitle2),
              ],
            ),
      
            // Skip Button
            SkipButton(onSkip: _onSkip),
      
            // Dot Indicator
            OnboardingDotNavigation(controller: pageController),
      
            // Circular Button
            OnBoardingNextButton(onNext: _onNext),
          ],
        ),
      ),
    );
  }

  void _onSkip() {
    context.pushNamed(Routes.loginScreen);
  }

  void _onNext() {
    if (currentPage < 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {currentPage++;});
    } else {
      context.pushNamed(Routes.loginScreen);
    }
  }
}