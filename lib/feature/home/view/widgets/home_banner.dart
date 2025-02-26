import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/app_slider.dart';
import 'package:tjhaz/feature/home/data/models/banner_model.dart';

import '../../../../core/utils/cached_network_img_helper.dart';


class HomeBanner extends StatefulWidget {
  final List<BannerModel> banners;


  const HomeBanner({super.key, required this.banners });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  late List<String> imageList;

  int currentIndex = 0 ;


  @override
void initState() {
imageList = widget.banners.map((banner) => banner.image).toList();
super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AppSlider(imageList: imageList, height: screenHeight(context)*0.225,);
  }
}
