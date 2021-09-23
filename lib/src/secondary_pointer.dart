import 'package:flutter/material.dart';
import 'package:wheel_date_picker/wheel_date_picker.dart';

class SecondaryPointer extends StatelessWidget {
  SecondaryPointer({
    Key? key,
    this.width = 3,
    this.height = 130,
    this.color = Colors.grey,
    this.borderRadius = 30,
  }) : super(key: key);

  /// If non-null, requires the child to have exactly this Width.
  final int width;

  /// If non-null, requires the child to have exactly this height.
  final int height;

  /// The color of the gradation.
  final Color color;

  final int borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        color: color,
      ),
    );
  }
}
