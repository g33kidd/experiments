import 'package:flutter/widgets.dart';

// TODO support for other developers to come in and showcase their experiments.
// config file will get large with that though? another way?
class Experiment {
  final String name;
  final String description;
  final String route;
  final String maker; // whoever made this Experiment.
  final Color color; // not sure if going to use color..
  final WidgetBuilder widget;

  Experiment({
    @required this.name,
    @required this.description,
    @required this.route,
    @required this.widget,
    this.maker,
    this.color,
  });
}
