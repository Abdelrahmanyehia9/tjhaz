import 'package:flutter/material.dart';
import 'package:tjhaz/core/styles/colors.dart';

class BoxActionButton extends StatelessWidget {
  final IconData icon ;
  const BoxActionButton({super.key  , required this.icon});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
borderRadius: BorderRadius.circular(8)
      ),
      child: Icon(icon , color: Colors.white,size: 22,),
    );
  }
}
