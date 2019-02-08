import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'config.dart';

void main() => runApp(Experiments());

// App.of(context).getExperiments();

Map<String, WidgetBuilder> buildRoutes() {
  Map<String, WidgetBuilder> routes = {
    '/home': (_) => HomePage(),
  };

  experimentsList.forEach((f) {
    routes.addAll({
      f.route: f.widget,
    });
  });

  return routes;
}

class Experiments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiments',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: buildRoutes(),
    );
  }
}
