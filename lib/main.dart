import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(Experiments());

class Experiments extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiments',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ParticlePaintBody(),
            Center(
              child: Container(
                width: 350.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue[600].withAlpha(100),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white70,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white70,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    // particles.forEach((particle))
    // Paint particle = Paint()
    //   ..color = Colors.lightBlue[100]
    //   ..strokeWidth = 1.0
    //   ..style = PaintingStyle.fill;

    // Paint connector = Paint()
    //   ..color = Colors.lightBlue[100]
    //   ..strokeWidth = 1.0
    //   ..style = PaintingStyle.stroke;

    // // canvas.drawColor(Colors.grey[700], BlendMode.);
    // Offset center = Offset(size.width / 2, size.height / 2);
    // Offset topLeft = Offset(size.width / 2 - 100, size.height / 2 - 100);

    // Offset bottomRight = Offset(size.width / 2 + 100, size.height / 2 + 200);
    // Offset otherRight = Offset(size.width / 2 - 10, size.height / 2 + 220);

    // canvas.drawCircle(center, 6.0, particle);
    // canvas.drawCircle(topLeft, 6.0, particle);
    // canvas.drawCircle(bottomRight, 6.0, particle);
    // canvas.drawCircle(otherRight, 6.0, particle);

    // canvas.drawLine(center, topLeft, connector);
    // canvas.drawLine(bottomRight, otherRight, connector);
  }

  void linkParticles(Canvas canvas, Particle p1, Particle p2) {
    double dx = p1.position.dx - p2.position.dx;
    double dy = p1.position.dy - p2.position.dy;
    int dist = sqrt((dx * dx + dy * dy).toDouble()).toInt();

    if (dist < 225) {
      pathPaint.color = pathPaint.color.withAlpha(250 - dist);
      canvas.drawLine(p1.position, p2.position, pathPaint);

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
