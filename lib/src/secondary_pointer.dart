import 'package:flutter/material.dart';

class SecondaryPointer extends StatelessWidget {
  SecondaryPointer({
    Key? key,
    this.width = 3.0,
    this.height = 130.0,
    this.color = Colors.grey,
    this.borderRadius = 30.0,
  }) : super(key: key);

  /// If non-null, requires the child to have exactly this Width.
  final double width;

  /// If non-null, requires the child to have exactly this height.
  final double height;

  /// The color of the gradation.
  final Color color;

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
    );
  }
}
