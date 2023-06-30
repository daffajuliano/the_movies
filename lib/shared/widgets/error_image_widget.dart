import 'package:flutter/material.dart';

class ErrorImageWidget extends StatelessWidget {
  final bool isPoster;

  const ErrorImageWidget({Key? key, this.isPoster = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: isPoster ? 200 : 75,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported),
      ),
    );
  }
}
