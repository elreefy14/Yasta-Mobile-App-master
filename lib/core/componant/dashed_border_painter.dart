import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create a rounded rectangle path
    final roundedRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    final path = Path()..addRRect(roundedRect);

    // Draw the dashed path with the rounded rectangle
    final dashPattern = [dashWidth, dashSpace];
    _drawDashedPath(canvas, path, paint, dashPattern);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint, List<double> dashPattern) {
    double distance = 0.0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final length = dashPattern[0];
        final space = dashPattern[1];
        canvas.drawPath(
          metric.extractPath(distance, distance + length),
          paint,
        );
        distance += length + space;
      }
      distance = 0.0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
