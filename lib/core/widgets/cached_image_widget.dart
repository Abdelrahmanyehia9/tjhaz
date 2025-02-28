import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imgUrl;

  const CachedImageWidget({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[300], // Placeholder background color
        child: Center(
          child: CircularProgressIndicator(), // Loading indicator
        ),
      ),
      errorWidget: (context  ,url  , error) =>Container(
        color: Colors.grey[300],
        child: Center(
          child: Icon(Icons.error, color: Colors.red, size: 30),
        ),
      )
    );
  }
}
