import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class ColorScreen extends StatelessWidget {
  final Color screenColor;

  const ColorScreen(this.screenColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'rgba (${screenColor.red},${screenColor.green},${screenColor.blue}:${screenColor.alpha})'),
      ),
      body: Container(
        color: screenColor,
      ),
    );
  }
}
