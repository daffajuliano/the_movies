import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PosterImageShimmer extends StatelessWidget {
  const PosterImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}