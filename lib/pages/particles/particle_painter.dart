import 'package:flutter/material.dart';
import 'dart:math';

import 'particle.dart';

class ParticlePainter extends CustomPainter {
  Offset position;
  Paint particlePaint;
  List<Particle> particles;
  Path path;

  static Color color = Colors.lightGreen[100];

  Paint pathPaint = Paint()
    ..color = color
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  ParticlePainter({this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey[850], BlendMode.src);
    particles.forEach((particle) => particle.draw(canvas, size));
    particles.forEach((p) {
      particles.forEach((p2) {
        linkParticles(canvas, p, p2);
      });
    });
  }

  void linkParticles(Canvas canvas, Particle p1, Particle p2) {
    double dx = p1.position.dx - p2.position.dx;
    double dy = p1.position.dy - p2.position.dy;
    int dist = sqrt((dx * dx + dy * dy).toDouble()).toInt();

    if (dist < 225) {
      pathPaint.color = pathPaint.color.withAlpha(250 - dist);
      canvas.drawLine(p1.position, p2.position, pathPaint);

      // why tf doesn't path work?
      // path.moveTo(p1.position.dx, p1.position.dy);
      // path.lineTo(p2.position.dx, p2.position.dy);
      // // path.fillType = PathFillType.evenOdd;
      // pathPaint.color = pathPaint.color.withAlpha(250 - dist);
      // canvas.drawPath(path, pathPaint);

      // path.reset();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
