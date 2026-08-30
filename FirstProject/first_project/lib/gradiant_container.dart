import 'package:flutter/material.dart';
import 'dice_roller.dart';


var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;



class GradiantContainer extends StatelessWidget {
  final List<Color> gradiantColors;

  const GradiantContainer(this.gradiantColors, {super.key});
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradiantColors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child:DiceRoller(),
      ),
    );
  }
}
