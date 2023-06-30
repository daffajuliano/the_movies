import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PosterShimmer extends StatelessWidget {
  const PosterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
            ),
            Container(
              width: double.infinity,
              height: 20,
              margin: const EdgeInsets.only(bottom: 8),
              color: Colors.grey.shade400,
            ),
            Container(
              height: 20,
              width: 60,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}