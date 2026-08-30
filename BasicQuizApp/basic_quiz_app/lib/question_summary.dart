import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});
  final List<Map<String, Object>> summaryData;
  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: data['userAnswer'] == data['correctAnswer'] ? const Color.fromARGB(255, 53, 167, 225) : const Color.fromARGB(255, 255, 133, 150),
                    shape: BoxShape.circle,
                  ),  
                  child: Text(
                    ((data['questionIndex'] as int) + 1).toString(),
                    style: GoogleFonts.lato(color: Colors.deepPurple, fontSize:12, fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width:10),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(width:double.infinity, child: Text(data['question'] as String, style: GoogleFonts.lato(color: Colors.white, fontSize: 16,), textAlign: TextAlign.left,)),
                      SizedBox(width:double.infinity, child: Text(data['correctAnswer'] as String, style: GoogleFonts.lato(color: const Color.fromARGB(255, 97, 202, 255), fontSize: 14,), textAlign: TextAlign.left,)),
                      SizedBox(width:double.infinity, child: Text(data['userAnswer'] as String, style: GoogleFonts.lato(color: const Color.fromARGB(255, 181, 138, 255), fontSize: 14,), textAlign: TextAlign.left,)),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
