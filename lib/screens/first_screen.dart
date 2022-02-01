import 'dart:math';
import 'package:flutter/material.dart';
import 'package:week13_other_animations/animation/slider_route.dart';
import 'package:week13_other_animations/animation/drop_text.dart';
import 'package:week13_other_animations/screens/second_screen.dart';
import 'package:week13_other_animations/screens/first_hero_screen.dart';

//начальный экран проиложения

class FirstScreen extends StatefulWidget{
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin {

  //контроллер и анимация для плавного появления картинок
  late AnimationController _controllerOpacity;
  late Animation<double> _animationOpacity;

  //контроллер для вращения картинки (вращается постоянно)
  late AnimationController _controllerRotation = AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
  )
    ..repeat();

  @override
  void initState() {
    //картинки начинают появляться при старте приложения
    _controllerOpacity = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(_controllerOpacity);
    _controllerOpacity.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controllerRotation.dispose();
    _controllerOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Some animations'),
        ),
        body: Center(child: Column(
          children: [
            //AnimatedBuilder - вращение картинки
            //FadeTransition - её плавное появление
            AnimatedBuilder(
              animation: _controllerRotation,
              child: FadeTransition(
                opacity: _animationOpacity,
                child: Image.asset('images/owl.png', scale: 4,),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controllerRotation.value * 2.0 * pi,
                  child: child,
                );
              },
            ),
            //выдвигающийся текст
            DropText(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    //плавное появление картинки
                    FadeTransition(
                      opacity: _animationOpacity,
                      child: Hero(
                          tag: 'horse',
                          child: Image.asset('images/horse.png', scale: 7,)
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    //по нажатию кнопки с Hero анимацией происходит переход
                    //на FirstHeroScreen
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => FirstHeroScreen()
                        ));
                      },
                      child: Text('Bigger picture'),
                    )
                  ],
                ),
              ),
            ),
            //по нажатию кнопки просходит переход на SecondScreen
            //с анимацией выдвижения справа налево
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, SliderRoute(page: SecondScreen()));
              },
              child: Text('To the second screen'),
            ),
          ],
        ))
    );
  }
}