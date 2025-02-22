import 'package:flutter/material.dart';

class CachedImageHelper {
  static Widget imagePlaceholder() {
    return Container(
      color: Colors.grey[300], // Placeholder background color
      child: Center(
        child: CircularProgressIndicator(), // Loading indicator
      ),
    );
  }

  static Widget imageErrorWidget() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Icon(Icons.error, color: Colors.red, size: 30),
      ),
    );
  }
}
