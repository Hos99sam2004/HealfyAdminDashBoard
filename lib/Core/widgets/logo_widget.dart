import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? size;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const Logo({
    Key? key,
    this.size,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = width ?? size;
    final h = height ?? size;
    return Image.asset(
      'assets/images/logo copy.png',
      width: w,
      height: h,
      fit: fit,
      color: color,
    );
  }
}
