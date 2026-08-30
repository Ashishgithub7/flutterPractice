  import 'package:flutter/material.dart';
  import 'dart:math';
  
  var randomizer =Random();
  class DiceRoller extends StatefulWidget{

    const DiceRoller({super.key});

    @override
    State<DiceRoller> createState(){
      return _DiceRollerState();
    }
  }

  class _DiceRollerState extends State<DiceRoller>{

    var diceValue = 2;

    void rollDice() {
      setState((){
        diceValue = randomizer.nextInt(6) + 1;
      });
    } 
  
    @override
    Widget build(context){
      return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/dice-$diceValue.png',
              width: 150,
              alignment: Alignment.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: rollDice,
              child: Text(
                'Roll Dice',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ],
        );
    }
  }