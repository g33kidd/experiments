import 'package:experiments/model/experiment.dart';
import 'package:flutter/material.dart';
import 'package:experiments/config.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: experimentsList.length,
          itemBuilder: (BuildContext context, int index) {
            final experiment = experimentsList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExperimentCard(
                experiment: experiment,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExperimentCard extends StatelessWidget {
  final Experiment experiment;
  final BorderRadius _radius = BorderRadius.circular(4.0);

  ExperimentCard({this.experiment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(experiment.route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: _radius,
          // border: Border.all(color: experiment.color, width: 2.0),
        ),
        child: ClipRRect(
          borderRadius: _radius,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  experiment.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  experiment.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueGrey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
