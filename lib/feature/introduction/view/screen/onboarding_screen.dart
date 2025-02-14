
import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/typography.dart';
import '../widget/on_boarding_buttons.dart';
import '../widget/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
 State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/on1.png", // Change to your actual image path
      "title": "ENJOY\nAND RELAX\nTOGETHER",
    }, { "image": "assets/images/on2.png", "title": "Let's\ndiscover\nthe world"}, {
      "image": "assets/images/on3.png",
      "title": "Laughter\nand play\nstarts here",
    }

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) => OnboardingContent(
              image: onboardingData[index]["image"]!,
              title: onboardingData[index]["title"]!,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => buildDot(index),
                  ),
                ),
                verticalSpace( 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OnBoardingButtons(onPressed: (){} , isSkip: true,) ,
                    OnBoardingButtons( onPressed: () {
                      if (_currentPage < onboardingData.length - 1) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      } else {
                        // Navigate to next screen
                      }
                    },),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    bool isActive = _currentPage == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      child: isActive
          ? Text(
       '0${index + 1}',
        style: AppTypography.t20Bold.copyWith(color: Colors.white)
      )
          : Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

}

