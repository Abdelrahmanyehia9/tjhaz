import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:tjhaz/core/helpers/spacing.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

class TogglePages extends StatefulWidget {
  final List<String> title ;
  final List<Widget> pages;

  const TogglePages({super.key , required this.pages , required this.title});

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends State<TogglePages> {

  late List<DataTab> _listTextTabToggle ;
  int _tabTextIndexSelected = 0;
  @override
  void initState() {

    _listTextTabToggle = List.generate(widget.title.length,(item)=> DataTab(title:widget.title[item] ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterToggleTab(
          width: 90.w,
          isScroll: false,
          borderRadius: 8,
          height: 50.h,
          selectedIndex: _tabTextIndexSelected,
          unSelectedBackgroundColors: [AppColors.primaryColor],
          selectedBackgroundColors: [AppColors.secondaryColor],
          selectedTextStyle:
          AppTypography.t16Normal.copyWith(color: AppColors.cWhite),
          unSelectedTextStyle:
          AppTypography.t16Normal.copyWith(color: AppColors.cWhite),
          dataTabs: _listTextTabToggle,
          selectedLabelIndex: (index) {
            setState(() {
              _tabTextIndexSelected = index;
            });
          },
        ),
        verticalSpace(12) ,
        widget.pages[_tabTextIndexSelected]
      ],
    );
  }
}