
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/app_router.dart';
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
      "title": AppStrings.enjoyAndRelax.toUpperCase(),
    }, { "image": "assets/images/on2.png", "title": AppStrings.discoverWorld.toUpperCase()}, {
      "image": "assets/images/on3.png",
      "title": AppStrings.laughterAndPlay.toUpperCase(),
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
            bottom: 50.h,
            left: 20.w,
            right: 20.w,
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
                    OnBoardingButtons(onPressed: ()async{
                      GoRouter.of(context).go(AppRouter.authScreen) ;
                      await SharedPrefHelper.setBool(SharedPrefConstants.isFirstTime, false) ;
                    } , isSkip: true,) ,
                    OnBoardingButtons( onPressed: ()  async{
                      if (_currentPage < onboardingData.length - 1) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      } else {

                        GoRouter.of(context).go(AppRouter.authScreen) ;
                        await SharedPrefHelper.setBool(SharedPrefConstants.isFirstTime, false) ;

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
      margin:  EdgeInsets.only(right: 5.w),
      child: isActive
          ? Text(
       '0${index + 1}',
        style: AppTypography.t20Bold.copyWith(color: Colors.white)
      )
          : Container(
        height: 8.h,
        width: 8.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

}

