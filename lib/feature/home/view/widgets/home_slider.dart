import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tjhaz/core/utils/screen_size.dart';

class HomeSlider extends StatefulWidget {
  final List<String> imageList;

  const HomeSlider({super.key, required this.imageList});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int currentIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: screenHeight(context)*.225, // Adjust the height as needed
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction:1,
            aspectRatio: 16 / 9,
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
              borderRadius: BorderRadius.circular(12), // Rounded corners
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
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
