import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_svg/svg.dart';

// class CustomImage extends StatelessWidget {
//   const CustomImage({
//     super.key,
//     required this.path,
//     this.fit = BoxFit.contain,
//     this.height,
//     this.width,
//     this.color,
//     this.isFile = false,
//   });
//
//   final String path;
//   final BoxFit fit;
//   final double? height, width;
//   final Color? color;
//   final bool isFile;
//
//   @override
//   Widget build(BuildContext context) {
//     if (isFile) {
//       return Image.file(
//         File(path),
//         fit: fit,
//         color: color,
//         height: height,
//         width: width,
//       );
//     }
//
//     if (path.endsWith('.svg')) {
//       if (path.startsWith('http') || path.startsWith('https')) {
//         return SvgPicture.network(
//           path,
//           fit: fit,
//           height: height,
//           width: width,
//           color: color,
//           placeholderBuilder: (context) =>
//               const Center(child: Icon(Icons.error)),
//         );
//       } else {
//         return SvgPicture.asset(
//           path,
//           fit: fit,
//           height: height,
//           width: width,
//           color: color,
//           placeholderBuilder: (context) =>
//               const Center(child: Icon(Icons.error)),
//         );
//       }
//     }
//     if (path.startsWith('http') ||
//         path.startsWith('https') ||
//         path.startsWith('www.')) {
//       return CachedNetworkImage(
//         imageUrl: path,
//         fit: fit,
//         color: color,
//         height: height,
//         width: width,
//         progressIndicatorBuilder: (context, url, downloadProgress) {
//           return Center(
//             child: CircularProgressIndicator(value: downloadProgress.progress),
//           );
//         },
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       );
//     }
//     return Image.asset(
//       path,
//       fit: fit,
//       color: color,
//       height: height,
//       width: width,
//     );
//   }
// }

// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../utils/k_images.dart';
//
// class CustomImage extends StatelessWidget {
//   const CustomImage({
//     Key? key,
//     required this.source,
//     this.fit = BoxFit.contain,
//     this.height,
//     this.width,
//     this.color,
//     this.isFile = false,
//   }) : super(key: key);
//   final String? source;
//   final BoxFit fit;
//   final double? height, width;
//   final Color? color;
//   final bool isFile;
//
//   @override
//   Widget build(BuildContext context) {
//     final imageSource = source ?? KImages.kNetworkImage;
//
//     if (isFile) {
//       return Image.file(
//         File(imageSource),
//         fit: fit,
//         color: color,
//         height: height,
//         width: width,
//       );
//     }
//
//     if (imageSource.endsWith('.svg')) {
//       return SizedBox(
//         height: height,
//         width: width,
//         child: SvgPicture.asset(
//           imageSource,
//           fit: fit,
//           height: height,
//           width: width,
//           color: color,
//         ),
//       );
//     }
//     if (imageSource.startsWith('http') ||
//         imageSource.startsWith('https') ||
//         imageSource.startsWith('www.')) {
//       return CachedNetworkImage(
//         imageUrl: imageSource,
//         fit: fit,
//         color: color,
//         height: height,
//         width: width,
//         progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//             child: CircularProgressIndicator(value: downloadProgress.progress)),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       );
//     }
//     return Image.asset(
//       imageSource,
//       fit: fit,
//       color: color,
//       height: height,
//       width: width,
//     );
//   }
// }

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  });

  final String path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    if (isFile) {
      return Image.file(
        File(path),
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }

    // Check for SVG format
    if (path.endsWith('.svg')) {
      if (path.startsWith('http') || path.startsWith('https')) {
        return SvgPicture.network(
          path,
          fit: fit,
          height: height,
          width: width,
          color: color,
          placeholderBuilder: (context) =>
          const Center(child: Icon(Icons.error)),
        );
      } else {
        return SvgPicture.asset(
          path,
          fit: fit,
          height: height,
          width: width,
          color: color,
          placeholderBuilder: (context) =>
          const Center(child: Icon(Icons.error)),
        );
      }
    }

    // Check for network image (supports WebP, JPG, PNG, etc.)
    if (path.startsWith('http') ||
        path.startsWith('https') ||
        path.startsWith('www.')) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        color: color,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    // Check for WebP in local assets
    if (path.endsWith('.webp')) {
      return Image.asset(
        path,
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }

    // Fallback for other local asset images
    return Image.asset(
      path,
      fit: fit,
      color: color,
      height: height,
      width: width,
    );
  }
}

