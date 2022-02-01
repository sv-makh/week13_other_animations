import 'dart:math';
import 'package:flutter/material.dart';
import 'package:week13_other_animations/animation/slider_route.dart';
import 'package:week13_other_animations/screens/second_screen.dart';
import 'package:week13_other_animations/screens/first_hero_screen.dart';

class FirstScreen extends StatefulWidget{
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin {

  late AnimationController _controllerOpacity;
  late Animation<double> _animationOpacity;

  late AnimationController _controllerArrow;

  late AnimationController _controllerDropDown = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late Animation<double> _animationDropDown = CurvedAnimation(
    parent: _controllerDropDown,
    curve: Curves.easeIn,
  );

  bool _dropDownShow = false;

  late AnimationController _controllerRotation = AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
  )
    ..repeat();

  @override
  void initState() {
    _controllerOpacity = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(_controllerOpacity);

    _controllerArrow = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3)
    );

    //super.initState();
  }

  @override
  void dispose() {
    _controllerRotation.dispose();
    _controllerOpacity.dispose();
    _controllerDropDown.dispose();
    _controllerArrow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerOpacity.forward();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Some animations'),
        ),
        body: Center(child: Column(
          children: [
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
            Card(child: ListTile(
              title: Text('Press arrow'),
              trailing: GestureDetector(
                child: RotationTransition(
                    turns: Tween(begin: 0.0, end: -0.5).animate(
                        _controllerArrow),
                    child: Icon(Icons.arrow_upward)
                ),
                onTap: () {
                  if (_dropDownShow == false) {
                    _controllerDropDown.forward();
                    _controllerArrow.forward();
                    _dropDownShow = true;
                  } else {
                    _controllerDropDown.reverse();
                    _controllerArrow.reverse();
                    _dropDownShow = false;
                  }
                },
              ),
            )),
            SizeTransition(
                sizeFactor: _animationDropDown,
                axis: Axis.vertical,
                axisAlignment: -1,
                child: Card(child: ListTile(
                  title: Text('''
owl-
two yellow moons
in slow rotation'''),
                ))),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    FadeTransition(
                      opacity: _animationOpacity,
                      child: Hero(
                          tag: 'horse',
                          child: Image.asset('images/horse.png', scale: 7,)
                      ),
                    ),
                    SizedBox(width: 20.0,),
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