import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/feature/auth/logic/anonymous_user_cubit.dart';
import '../../../booking/view/screen/my_bookings_screen.dart';
import '../../../profile/view/screen/profile_screen.dart';
import '../../../categories/view/screen/all_categories_screen.dart';
import '../../../home/view/screen/home_screen.dart';

class HomeLayout extends StatefulWidget {
  final int initialIndex ;
  const HomeLayout({super.key , this.initialIndex = 0});

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
  void initState() {
    _selectedIndex = widget.initialIndex ;
context.read<AnonymousUserCubit>().checkAnonymousUser() ;
super.initState();
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
