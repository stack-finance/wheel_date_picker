import 'package:flutter/material.dart';

class PointerConfig {
  PointerConfig({
    this.width = 2,
    this.height = 96,
    this.secondaryHeight = 48,
    this.color = const Color(0xffcccad8),
    this.gap = 40,
  });

  /// If non-null, requires the child to have exactly this Width.
  final int width;

  /// If non-null, requires the child to have exactly this height.
  final int height;

  final int secondaryHeight;

  final Color color;

  final int gap;
}
