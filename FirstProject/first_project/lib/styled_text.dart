import 'package:flutter/material.dart';

class StyledText extends StatelessWidget{

  final String text;
  const StyledText(this.text,{super.key});

  @override
  Widget build(context){
    return Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: 'Arial',
              ),
            );
  }
}