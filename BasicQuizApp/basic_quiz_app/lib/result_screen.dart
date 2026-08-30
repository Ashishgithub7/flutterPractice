import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/questions.dart';
import 'question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
    this.restartQuiz, {
    super.key,
    required this.choosenAnswers,
  });
  final void Function() restartQuiz;
  final List<String> choosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < questions.length; i++) {
      summary.add({
        'questionIndex': i,
        'question': questions[i].question,
        'correctAnswer': questions[i].answers[0],
        'userAnswer': choosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['correctAnswer'] == data['userAnswer'];
    }).length;

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You've got $numCorrectQuestions out of $numTotalQuestions correct answers!",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              QuestionSummary(summaryData),
              SizedBox(height: 30),
              TextButton.icon(
                onPressed: restartQuiz,
                icon: Icon(Icons.restart_alt_rounded, color: Colors.white),
                label: Text("Restart Quiz", style: GoogleFonts.lato(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
