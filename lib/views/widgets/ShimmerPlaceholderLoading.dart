import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholderLoading extends StatelessWidget {

  const ShimmerPlaceholderLoading({
    Key? key,
    required this.borderRadius,
    this.enable = true,
  }) : super(key: key);

  final double borderRadius;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300, 
      highlightColor: Colors.grey.shade100,
      enabled: enable,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.borderRadius),
          color: Colors.white,
        ),), );
  }
}