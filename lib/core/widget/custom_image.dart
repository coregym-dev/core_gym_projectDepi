import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/core/theme/app_color.dart';

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
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: BoxFit.cover,

        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: AppColors.dividerColor,
          child: const Center(
            child: CupertinoActivityIndicator(
              animating: true,
              color: AppColors.textSecondary,
            ),
          ),
        ),

        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image),
        ),
      ),
    );
  }
}
