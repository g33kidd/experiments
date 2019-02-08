import 'package:flutter/material.dart';
import 'dart:math';

class Particle {
  int id;
  double radius;
  double size;
  int alpha;
  static Color color = Colors.lightGreen[100];
  Random random;
  Offset position = Offset(1.0, 1.0);
  Offset vPos = Offset(1.0, 1.0);
  Size screenSize;

  Paint paint = Paint()
    ..color = color
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  Particle({
    @required this.id,
    this.size = 5.0,
    this.radius = 200.0,
    this.alpha,
    this.vPos,
    @required this.screenSize,
  }) {
    double xPos = Random.secure().nextInt(screenSize.width.toInt()).toDouble();
    double yPos = Random.secure().nextInt(screenSize.height.toInt()).toDouble();
    double vxPos = (-1.0 + Random.secure().nextInt(1 - -1).toDouble());
    double vyPos = (-1.0 + Random.secure().nextInt(1 - -1).toDouble());
    alpha = (150 + Random.secure().nextInt(255 - 150));

    position = Offset(xPos, yPos);
    vPos = Offset(vxPos, vyPos);
    // paint.color.withAlpha(alpha);
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawCircle(
      position,
      6.0,
      paint,
    );
  }

  void move() {
    double width = screenSize.width.toDouble();
    double height = screenSize.height.toDouble();

    double x = position.dx;
    double y = position.dy;

    position = Offset(x + vPos.dx, y + vPos.dy);

    // TODO
    /// I multiplied the size because it was getting destroyed pretty quickly
    /// as soon as it touches the edges. Still should figure out a better way.
    ///
    /// Instead of this, it should just bounce off the edges and maintain the connection
    /// to all the other circles. Would be smoother.
    if (position.dx < (0 - (size * 2))) {
      position = Offset(width, position.dy);
    } else if (position.dx > (width + (size * 2))) {
      position = Offset(0, position.dy);
    }

    if (position.dy < (0 - (size * 2))) {
      position = Offset(position.dx, height);
    } else if (position.dy > (height + (size * 2))) {
      position = Offset(position.dx, 0);
    }
  }
}
