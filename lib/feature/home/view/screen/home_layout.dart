import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/feature/categories/view/screen/all_categories_screen.dart';
import 'package:tjhaz/feature/home/view/screen/home_screen.dart';

import '../../../../core/styles/app_icon.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(AppIcons.home),
      label: AppStrings.home.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon:  Icon(AppIcons.categories),
  label: AppStrings.categories.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Icon(AppIcons.booking),
      label: AppStrings.bookings.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Icon(AppIcons.cart),
      label: AppStrings.cart.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: Icon(AppIcons.profile),
      label: AppStrings.profile.toUpperCase(),
    ),



  ];
  List<Widget>pages = [HomeScreen() , AllCategoriesScreen() , AllCategoriesScreen() , AllCategoriesScreen() ,AllCategoriesScreen()    ] ; 
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      
      bottomNavigationBar: SizedBox(height: 80.h,
        child: BottomNavigationBar(
        unselectedLabelStyle: AppTypography.t10light,
          selectedLabelStyle: AppTypography.t12Normal,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade200,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items:navItems,
          type: BottomNavigationBarType.fixed, // Keeps all labels visible
        ),
      ),
    );
  }
}