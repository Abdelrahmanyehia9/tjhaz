import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tjhaz/core/utils/constants.dart';

class RefreshableWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onRefresh;

  const RefreshableWidget({super.key, required this.child, this.onRefresh});

  @override
  State<RefreshableWidget> createState() => _RefreshableWidgetState();
}

class _RefreshableWidgetState extends State<RefreshableWidget> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() {
    widget.onRefresh?.call(); // استدعاء الدالة الخارجية إذا كانت موجودة
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      controller: _refreshController,
      onRefresh: _onRefresh,
      header: CustomHeader(
        height: 250.h,
        builder: (context, mode) => SizedBox(
          width: double.infinity,
          child: Lottie.asset(AppConstants.refreshLoading, fit: BoxFit.cover),
        ),
      ),
      child: widget.child,
    );
  }
}
