import 'package:flutter/material.dart';

//анимация выдвижения справа налево при переходе к экрану page

class SliderRoute extends PageRouteBuilder {
  final Widget page;

  SliderRoute({required this.page}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation
        ) => page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) => SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    ),
  );
}