import 'package:flutter/material.dart';

import 'particles/particle_widget.dart';

class ParticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ParticlePaintBody(),
            Center(
              child: AuthenticationForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthenticationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
