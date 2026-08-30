import 'package:flutter/material.dart';
import '/answer_button.dart';
import 'data/questions.dart';
import '/models/quiz_question.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen>{
  var currentQuestionIndex = 0;
  void answerQuestion(String answer){
    widget.onSelectAnswer(answer); 
    setState((){
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context){
  QuizQuestion currentQuestion = questions[currentQuestionIndex];
    return Center(
      child:SizedBox(
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(40),
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
          Text(
            currentQuestion.question,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            ),
          SizedBox(height: 30,),
          ...currentQuestion.getShuffledAnswers().map((answer){
            return AnswerButton(answerText: answer,
                                 onTap: (){
                                  
                                  answerQuestion(answer);
                                 },
                               );
          }),
          ]
        ),
      ),
      ),
    );
  }
}