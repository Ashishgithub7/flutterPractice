import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget{
  const StartScreen(this.switchScreen,{super.key});

  final void Function() switchScreen;
  
  @override
  Widget build(context){
    return Center (
            child: Column(
                mainAxisSize: MainAxisSize.min,
              children:[
                Image.asset("assets/images/quiz-logo.png",width:300,color:Color.fromARGB(160, 255, 255, 255)),
                SizedBox(height: 100,),
               Text("First Quiz App",style: TextStyle(fontSize: 24, color: Colors.white),),
               SizedBox(height: 15),
               OutlinedButton.icon(
                icon: Icon(Icons.arrow_right), 
                style:OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                   onPressed: switchScreen, 
                   label: Text("Start Quiz"),
                   ),
            ],
          ),
        );
  }

}