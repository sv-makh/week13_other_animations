import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget{
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin{

  late AnimationController _controllerOpacity;
  late Animation<double> _animationOpacity;

  late AnimationController _controllerRotation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
  )..repeat();

  @override
  void initState() {
    _controllerOpacity = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animationOpacity = Tween(begin:  0.0, end: 1.0).animate(_controllerOpacity);
  }

  @override
  void dispose() {
    _controllerRotation.dispose();
    _controllerOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerOpacity.forward();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Some animations'),
      ),
      body: Center( child: Column(
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
//to do: dropdown
//https://stackoverflow.com/questions/65685532/create-custom-dropdown-in-flutter-or-how-to-put-custom-dropdown-options-in-a-l
//https://fluttertutorial.in/flutter-drop-down-below-animation/
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

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second screen'),
      ),
      backgroundColor: Colors.green,
    );
  }
}

class FirstHeroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero screen'),
      ),
      body: Hero(
        tag: 'horse',
        child: Image.asset('images/horse.png'),
      ),
    );
  }
}

