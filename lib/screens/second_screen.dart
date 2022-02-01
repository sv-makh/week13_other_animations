import 'package:flutter/material.dart';

//экран для перехода с анимацией выдвижения

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second screen'),
      ),
      backgroundColor: Colors.amber,
    );
  }
}