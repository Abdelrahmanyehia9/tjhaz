import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tjhaz/core/helpers/constants.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/feature/home/view/screen/home_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 4.0.h),
        child: SvgPicture.asset(AppConstants.navHome),
      ),
      label: AppLocalizations.home.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 4.0.h),
        child: SvgPicture.asset(AppConstants.navCategories),
      ),
      label: AppLocalizations.categories.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 4.0.h),
        child: SvgPicture.asset(AppConstants.navBooking),
      ),
      label: AppLocalizations.bookings.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 4.0.h),
        child: SvgPicture.asset(AppConstants.navCart),
      ),
      label: AppLocalizations.cart.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.symmetric(vertical: 4.0.h),
        child: SvgPicture.asset(AppConstants.navProfile),
      ),
      label: AppLocalizations.profile.toUpperCase(),
    ),



  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0 ? SafeArea(child: HomeScreen()):  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${ _selectedIndex == 1 ? 'Category' : _selectedIndex == 2 ? 'Booking' : _selectedIndex == 3 ? 'Cart' : 'Profile'} Page",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("TO DO NEXT PHASE")
          ],
        ),
      ),
      
      bottomNavigationBar: SizedBox(height: 80.h,
        child: BottomNavigationBar(
        unselectedLabelStyle: AppTypography.t10light,
          selectedLabelStyle: AppTypography.t10light,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items:navItems,
          type: BottomNavigationBarType.fixed, // Keeps all labels visible
        ),
      ),
    );
  }
}