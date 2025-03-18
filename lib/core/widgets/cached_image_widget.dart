import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_assets.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imgUrl;

  const CachedNetworkImageWidget({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[200], // Placeholder background color
        child: Opacity(
          opacity: 0.7,
          child: Center(
            child: Padding(
              padding:  EdgeInsets.all(36.0.w),
              child: Image.asset(AppAssets.splashLogo , width: 150.w, fit: BoxFit.contain,),
            ) // Loading indicator
          ),
        ),
      ),
      errorWidget: (context  ,url  , error) =>Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.error, color: Colors.red, size: 30),
        ),
      )
    );
  }
}
