import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/screen_size.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

class TogglePages extends StatefulWidget {
  final List<String> title;

  final List<Widget> pages;
  final double? width;

  final bool? isScroll;

  final double? height;

  final Color? unSelectedBackgroundColors;

  final Color? selectedBackgroundColors;

  final TextStyle? unSelectedTextStyle;
final void Function(int)? onTap ;
  final TextStyle? selectedTextStyle;

  final double? vSpace;

  const TogglePages(
      {super.key,
      required this.pages,
      required this.title,
      this.width,
      this.isScroll,
        this.onTap ,
      this.height,
      this.unSelectedBackgroundColors,
      this.selectedBackgroundColors,
      this.unSelectedTextStyle,
      this.selectedTextStyle,
      this.vSpace});

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends State<TogglePages> {
  late List<DataTab> _listTextTabToggle;

  int _tabTextIndexSelected = 0;

  @override
  void initState() {
    _listTextTabToggle = List.generate(
        widget.title.length, (item) => DataTab(title: widget.title[item]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutterToggleTab(
          width: widget.width?? 90.w ,
          isScroll: widget.isScroll ?? false,
          borderRadius: 8,
          height: widget.height ?? 50.h,
          selectedIndex: _tabTextIndexSelected,
          unSelectedBackgroundColors: [
            widget.unSelectedBackgroundColors ?? AppColors.primaryColor
          ],
          selectedBackgroundColors: [
            widget.selectedBackgroundColors ?? AppColors.secondaryColor
          ],
          selectedTextStyle: widget.selectedTextStyle ??
              AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
          unSelectedTextStyle: widget.unSelectedTextStyle ??
              AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
          dataTabs: _listTextTabToggle,
          selectedLabelIndex: (index) {
            setState(() {
              _tabTextIndexSelected = index;
            });
            widget.onTap != null ? widget.onTap!(index) : null ;

          },
        ),
        verticalSpace(widget.vSpace ?? 12),
        widget.pages[_tabTextIndexSelected]
      ],
    );
  }
}
