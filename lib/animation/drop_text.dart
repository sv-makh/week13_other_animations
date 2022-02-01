import 'package:flutter/material.dart';

//выдвигающийся текст и вращающаяся стрелка

class DropText extends StatefulWidget{
  const DropText({Key? key}) : super(key: key);

  @override
  State<DropText> createState() => _DropTextState();
}

class _DropTextState extends State<DropText> with TickerProviderStateMixin {
  //контроллер для вращения стрелки
  late AnimationController _controllerArrow;

  //контроллер и анимация для выдвигащегося текста
  late AnimationController _controllerDropDown = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late Animation<double> _animationDropDown = CurvedAnimation(
    parent: _controllerDropDown,
    curve: Curves.easeIn,
  );

  //состояние выдвигающего текста (выдвинут или нет)
  //а также стрелки (направлена вверх или вниз)
  bool _dropDownShow = false;

  @override
  void initState() {
    //конртроллер для вращения стрелки
    _controllerArrow = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3)
    );

    super.initState();
  }

  @override
  void dispose() {
    _controllerDropDown.dispose();
    _controllerArrow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(child: ListTile(
        title: Text('Press arrow'),
        trailing: GestureDetector(
          child: RotationTransition(
            //вращение против часовой стрелки на 90 градусов
              turns: Tween(begin: 0.0, end: -0.5).animate(
                  _controllerArrow),
              child: Icon(Icons.arrow_upward)
          ),
          onTap: () {
            //если стрелка вверх и текст не выдвинут,
            //стрелка вращается вниз (RotationTransition)
            // и выдвигается текст (SizeTransition)
            if (_dropDownShow == false) {
              _controllerDropDown.forward();
              _controllerArrow.forward();
              _dropDownShow = true;
            } else {
              //иначе стрелка вращается вверх и текст задвигается
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
          )))
    ]
    );
  }
}
