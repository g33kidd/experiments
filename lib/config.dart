import 'model/experiment.dart';
import 'pages/particles.dart';
import 'package:flutter/material.dart';

final experimentsList = <Experiment>[
  Experiment(
    name: "Particles",
    description:
        "Login form that also has some particles in the background. This was built primarily to learn CustomPaint stuff.",
    color: Colors.blue[400],
    route: "/particles",
    maker: 'g33kidd',
    widget: (_) => ParticlesPage(),
  ),
  Experiment(
    name: "TODO List",
    description: "TODO List. It's pretty simple.",
    color: Colors.orange[400],
    route: '/todo-list',
    // maker: 'g33kidd',
    widget: (_) => ParticlesPage(),
  ),
];
