import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double radious;
  const CustomImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.radious,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radious),
      child: Image.network(
        image,
        width: width,
        height: height,
        fit: BoxFit.fill,
        errorBuilder: (_, __, ___) {
          return const Icon(Icons.image_not_supported);
        },
      ),
    );
  }
}
