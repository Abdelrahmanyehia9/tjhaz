import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/cached_image_widget.dart';


class BannerSlider extends StatefulWidget {
  final List<String> imageList;


  const BannerSlider({super.key, required this.imageList ,} );

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int currentIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: screenWidth(context),
            child: CarouselSlider(
      
              options: CarouselOptions(
      
                height: screenHeight(context)*.225 ,
                // Adjust the height as needed
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction:1,
                autoPlayInterval: const Duration(seconds: 3),
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
      
      
        ],
      ),
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
