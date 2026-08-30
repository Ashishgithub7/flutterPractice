import 'package:flutter/material.dart';
import 'start_screen.dart';
import 'question_screen.dart';
import 'data/questions.dart';
import 'result_screen.dart';
 
class Quiz extends StatefulWidget{
  
  const Quiz({super.key});
  @override
  State<Quiz> createState(){
    return _QuizState();
  }
}

class _QuizState extends State<Quiz>{

  List<String> selectedAnswers = [];
  Widget ?activeScreen;
  @override
  void initState(){
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }
  
  void restartQuiz(){
    setState((){
      selectedAnswers = [];
      activeScreen = StartScreen(switchScreen);
    });
  }
  void switchScreen(){
    setState(() {
      activeScreen = QuestionScreen(onSelectAnswer: chooseAnswer,);
    });
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);
    if(selectedAnswers.length == questions.length){
      setState((){
        activeScreen = ResultScreen(restartQuiz,choosenAnswers: selectedAnswers,);
      });
    }
  }
  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.deepPurple),
          child: activeScreen,
        ),
      ),
    );
  }
}