
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BoxInnerShadow extends StatelessWidget {
  const BoxInnerShadow({
    Key? key,
    this.topShadow,
    this.bottomShadow,
    this.child,
  }) : super(key: key);

  final InnerShadow? topShadow;
  final InnerShadow? bottomShadow;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null)
          child!,
        if (topShadow != null)
        Container(
          width: double.infinity,
          height: topShadow!.size,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
                color: topShadow!.color,
                offset: topShadow!.offset,
                blurRadius: topShadow!.blurRadius,
              spreadRadius: topShadow!.blurRadius,
              )]))
        ,
        if (bottomShadow != null)
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: bottomShadow!.size,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: bottomShadow!.color,
                offset: bottomShadow!.offset,
                blurRadius: bottomShadow!.blurRadius,
                spreadRadius: bottomShadow!.blurRadius,
              )])),
        )
        ,
      ]
    );
  }
  
}

@immutable
class InnerShadow extends Shadow {
  final double size;

  InnerShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    required this.size,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

}
