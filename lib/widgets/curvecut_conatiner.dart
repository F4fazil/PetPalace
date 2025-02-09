import 'package:flutter/material.dart';

import '../constant/constant.dart';
class CurvedSplitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    // Define the first color
    paint.color = Color.fromARGB(255, 27, 220, 207); // Replace with your desired color
    Path leftPath = Path()
      ..lineTo(size.width * 0.5, 0) // Go to the center top
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.5, 0, size.height) // Curve to the bottom left
      ..close();
    canvas.drawPath(leftPath, paint);

    // Define the second color
    paint.color = app_bc;// Replace with your desired color
    Path rightPath = Path()
      ..moveTo(size.width * 0.5, 0) // Start from center top
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.5, size.width, size.height) // Curve to the bottom right
      ..lineTo(size.width, 0) // Draw line to top right corner
      ..close();
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
