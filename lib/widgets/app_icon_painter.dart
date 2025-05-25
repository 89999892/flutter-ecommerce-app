import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF5C6BC0)
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw shopping bag
    paint.color = Colors.white;
    final Path bagPath = Path();
    final double bagWidth = size.width * 0.6;
    final double bagHeight = size.height * 0.7;
    final double bagX = (size.width - bagWidth) / 2;
    final double bagY = (size.height - bagHeight) / 2;

    // Bag body
    bagPath.moveTo(bagX, bagY + bagHeight * 0.2);
    bagPath.lineTo(bagX, bagY + bagHeight);
    bagPath.lineTo(bagX + bagWidth, bagY + bagHeight);
    bagPath.lineTo(bagX + bagWidth, bagY + bagHeight * 0.2);

    // Bag handles
    final double handleWidth = bagWidth * 0.3;
    final double handleHeight = bagHeight * 0.2;
    bagPath.moveTo(bagX + bagWidth * 0.2, bagY + bagHeight * 0.2);
    bagPath.quadraticBezierTo(
      bagX + bagWidth * 0.35,
      bagY - handleHeight,
      bagX + bagWidth * 0.5,
      bagY + bagHeight * 0.2,
    );
    bagPath.moveTo(bagX + bagWidth * 0.5, bagY + bagHeight * 0.2);
    bagPath.quadraticBezierTo(
      bagX + bagWidth * 0.65,
      bagY - handleHeight,
      bagX + bagWidth * 0.8,
      bagY + bagHeight * 0.2,
    );

    canvas.drawPath(bagPath, paint);

    // Draw text
    const String text = 'E';
    final textStyle = ui.TextStyle(
      color: const Color(0xFF5C6BC0),
      fontSize: size.width * 0.3,
      fontWeight: FontWeight.bold,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textAlign: TextAlign.center,
    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(text);
    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: bagWidth));
    canvas.drawParagraph(
      paragraph,
      Offset(bagX + (bagWidth - paragraph.width) / 2, bagY + bagHeight * 0.3),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
