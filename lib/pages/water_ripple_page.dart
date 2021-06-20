import 'package:flutter/material.dart';
import 'package:oken/pages/water_rippler.dart';

class WaterRipplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(height: 200, width: 200, child: WaterRipple())),
    );
  }
}