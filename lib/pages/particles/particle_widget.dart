import 'package:flutter/material.dart';

import 'particle_painter.dart';
import 'particle.dart';

class ParticlePaintBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParticlePaintBodyState();
}

class _ParticlePaintBodyState extends State<ParticlePaintBody>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final particles = <Particle>[];
  final particleCount = 40;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..addListener(() {
            particles.forEach((p) => p.move());
          })
          ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        if (particles.isEmpty) {
          Size screenSize = MediaQuery.of(context).size;
          Iterable.generate(particleCount).forEach(
              (i) => particles.add(Particle(id: i, screenSize: screenSize)));
        }

        return CustomPaint(
          painter: ParticlePainter(
            particles: particles,
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}
