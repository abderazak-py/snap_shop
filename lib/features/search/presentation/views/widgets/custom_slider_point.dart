import 'package:flutter/material.dart';

class CustomSliderPoint extends RangeSliderThumbShape {
  const CustomSliderPoint({
    this.radius = 6,
    this.strokeWidth = 3,
    this.borderColor,
  });

  final double radius;
  final double strokeWidth;
  final Color? borderColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;

    // Fill (white) to create the hollow look
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Stroke matches the active track (or fallback to thumbColor)
    final strokePaint = Paint()
      ..color =
          borderColor ??
          (sliderTheme.activeTrackColor ??
              sliderTheme.thumbColor ??
              Colors.deepPurple)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, strokePaint);
  }
}
