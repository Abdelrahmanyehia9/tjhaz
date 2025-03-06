import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import '../../../booking/view/screen/my_bookings_screen.dart';
import '../../../profile/view/screen/profile_screen.dart';
import '../../../categories/view/screen/all_categories_screen.dart';
import '../../../home/view/screen/home_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
   int _selectedIndex = 0 ;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AllCategoriesScreen(),
    const MyBookingsScreen(),
    const AllCategoriesScreen(),
    const ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80.h,
        child: BottomNavigationBar(
          iconSize: 28.sp,
          unselectedLabelStyle: AppTypography.t10light,
          selectedLabelStyle: AppTypography.t12Normal,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade400,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(AppIcons.home),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.categories),
              label: AppStrings.categories,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.booking),
              label: AppStrings.bookings,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.cart),
              label: AppStrings.cart,
            ),
            BottomNavigationBarItem(
              icon: Icon(AppIcons.profile),
              label: AppStrings.profile,
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
