import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/cached_image_widget.dart';

import '../../feature/favorite/view/widgets/add_to_favorite.dart';

class AppSlider extends StatefulWidget {
  final List<String> imageList;
  final String id ;


  const AppSlider({super.key, required this.imageList , required this.id} );

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  int currentIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: screenWidth(context),
          child: CarouselSlider(

            options: CarouselOptions(

              height: screenHeight(context)*.3,
              // Adjust the height as needed
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction:1,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index ;

                });
              },
            ),
            items: widget.imageList.map((imageUrl) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                child: SizedBox(width: double.infinity,
                  child: CachedNetworkImageWidget(imgUrl: imageUrl),
                )
              );
            }).toList(),
          ),
        ),
        Positioned(
          bottom: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.imageList.length,
                    (index) => buildDot(index)
            ),
          ),
        ),
        Positioned(
          bottom: 8.h,
          right: 8.w,
          child: AddToFavorite(id: widget.id,),
        ),

      ],
    );
  }

  Widget buildDot(int index) {
    bool isActive = currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 4),
      child:  Container(
        height:8 ,
        width: isActive ?24 :8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
