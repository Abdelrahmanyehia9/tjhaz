import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tjhaz/core/styles/colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
    );
  }
}
