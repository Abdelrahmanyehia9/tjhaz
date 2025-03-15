import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/styles/app_icon.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/app_strings.dart';

class HomeLayoutShell extends StatefulWidget {
  final Widget child;

  const HomeLayoutShell({super.key, required this.child});

  @override
  State<HomeLayoutShell> createState() => _HomeLayoutShellState();
}

class _HomeLayoutShellState extends State<HomeLayoutShell> {
  int _selectedIndex = 0;

  // Using a non-empty string for cart to avoid route matching issues
  final List<String> _routes = [
    AppRouter.homeScreen,
    AppRouter.categoriesScreen,
    AppRouter.bookingsScreen,
    AppRouter.cartScreen, // Give cart a proper route path
    AppRouter.profileScreen
  ];

  @override
  void initState() {
    super.initState();
    // Set default value
    _selectedIndex = 0;

    // Schedule update after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateSelectedIndex();
      }
    });
  }

  void _updateSelectedIndex() {
    final String location = GoRouterState.of(context).matchedLocation;

    // Special handling for cart screen since it's a push navigation
    if (location == AppRouter.cartScreen) {
      setState(() {
        _selectedIndex = 3;
      });
      return;
    }

    // Check other routes
    int index = _routes.indexWhere((route) =>
    route.isNotEmpty && location.startsWith(route));

    setState(() {
      _selectedIndex = (index == -1) ? 0 : index;
    });
  }

  @override
  void didUpdateWidget(HomeLayoutShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update index when navigating between screens
    _updateSelectedIndex();
  }

  void _onItemTapped(int index) {
    // Handle cart navigation as a special case with push
    if (index == 3) {
      context.push(AppRouter.cartScreen);
      return;
    }

    // For other tabs, use go navigation
    if (_routes[index].isNotEmpty && _selectedIndex != index) {
      context.go(_routes[index]);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: SizedBox(
        height: 80.h,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: AppColors.cWhite,
          unselectedItemColor: AppColors.cLightGrey,
          selectedFontSize: 16.sp,
          showUnselectedLabels: false,
          unselectedFontSize: 12.sp,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildNavItem(AppIcons.home, AppStrings.home),
            _buildNavItem(AppIcons.categories, AppStrings.categories),
            _buildNavItem(AppIcons.booking, AppStrings.bookings),
            _buildNavItem(AppIcons.cart, AppStrings.cart),
            _buildNavItem(AppIcons.profile, AppStrings.profile),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 28.sp),
      label: label,
    );
  }
}