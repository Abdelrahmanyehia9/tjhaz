import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/icon_helper.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import '../styles/colors.dart';

class AppCalender extends StatefulWidget {
  final Color? disabledFillColor;
  final Color? selectedFillColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? textStyle;
  final Map<String, List<int>>? reservedDays;
  final Color? selectedBorderColor;
  final Color? borderColor;
  final Color? reservedBorderColor;
  final Widget? customHeadLine;
  final Function(DateTime)? onDateSelected;
  final Function(List<DateTime>)? onLongPress;
  final bool? enableMultiSelect ;
  final Color? enabledFillColor;
  final TextStyle? disabledTextStyle;

  const AppCalender({
    super.key,
    this.disabledTextStyle,
     this.enabledFillColor ,
    this.disabledFillColor,
    this.selectedFillColor,
    this.selectedTextStyle,
    this.textStyle,
    this.reservedDays,
    this.borderColor ,
    this.selectedBorderColor,
    this.reservedBorderColor,
    this.customHeadLine,
    this.onDateSelected,
    this.onLongPress,
    this.enableMultiSelect,

  });

  @override
  State<AppCalender> createState() => _AppCalenderState();
}

class _AppCalenderState extends State<AppCalender> {
  late DateTime _focusedDate;
  late DateTime _today;
  late DateTime _minDate;
  final List<DateTime> _selectedDates = [];
  DateTime? _lastSelectedDate;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _focusedDate = _today;
    _minDate = DateTime(_today.year, _today.month - 2, 1);
  }

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMMM yyyy').format(_focusedDate).toUpperCase();
    int daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    int firstWeekday = DateTime(_focusedDate.year, _focusedDate.month, 1).weekday;
    int emptyCells = firstWeekday % 7;

    return SizedBox(
        height: 360.h ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(8) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 20.sp, color: _focusedDate.isAfter(_minDate) ? AppColors.secondaryColor : Colors.grey),
                  onPressed: _focusedDate.isAfter(_minDate)
                      ? () => setState(() => _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1))
                      : null,
                ),
                Text(
                  formattedMonth,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color:AppColors.primaryColor),
                ),
                IconButton(
                  icon: Icon(
                      Icons.arrow_forward, color: AppColors.secondaryColor, size: 20.sp ),
                  onPressed: () => setState(() => _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1)),
                ),
              ],
            ),
            _buildWeekDaysHeader(),
            verticalSpace(8) ,
            Expanded(child: _buildCalendarGrid(daysInMonth, emptyCells)),
          ],
        ),
      ) ;

  }

  Widget _buildWeekDaysHeader() {
    List<String> weekDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDays
          .map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: AppTypography.t14Normal.copyWith(color: AppColors.secondaryColor),
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid(int daysInMonth, int emptyCells) {
    String monthKey = "${_focusedDate.year}-${_focusedDate.month.toString().padLeft(2, '0')}";
    List<int> bookedDays = widget.reservedDays?[monthKey] ?? [];
    List<Widget> dayWidgets = List.generate(emptyCells, (_) => Container());

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(_focusedDate.year, _focusedDate.month, day);
      bool isBooked = bookedDays.contains(day);
      bool isSelected = _selectedDates.contains(currentDate);
      bool isPast = currentDate.isBefore(_today.subtract(const Duration(days: 1)));

      dayWidgets.add(
        InkWell(
          onTap: (!isPast && !isBooked)
              ? () {
            setState(() {
              if (widget.enableMultiSelect??false) {
                if (_selectedDates.contains(currentDate)) {
                  _selectedDates.remove(currentDate);
                } else {
                  _selectedDates.add(currentDate);
                }
              } else {
                _selectedDates.clear();
                _selectedDates.add(currentDate);
              }
              _lastSelectedDate = currentDate;
            });
            if (widget.onDateSelected != null) {
              widget.onDateSelected!(currentDate);
            }
          }
              : null,
          onLongPress: widget.enableMultiSelect??false
              ? () {
            if (widget.onLongPress != null) {
              widget.onLongPress!(_selectedDates);
            }
          }
              : null,
          child: Container(
            width: 31.w,height: 31.h,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: isSelected ? widget.selectedFillColor ?? AppColors.secondaryColor  : isPast || isBooked ? widget.disabledFillColor ?? Colors.grey.shade300 : widget.enabledFillColor ?? Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: isPast || isBooked ? isSelected ?widget.selectedBorderColor??Colors.transparent:widget.reservedBorderColor?? Colors.transparent : widget.borderColor ?? AppColors.secondaryColor, width: 1.w),
            ),
            alignment: Alignment.center,
            child: Text(
              "$day",
              style:isPast || isBooked ? widget.disabledTextStyle ?? AppTypography.t14Normal.copyWith(color: Colors.grey) : widget.selectedTextStyle ?? AppTypography.t14Normal.copyWith(color: isSelected ? Colors.white :  AppColors.secondaryColor , fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: dayWidgets,
    );
  }
}
