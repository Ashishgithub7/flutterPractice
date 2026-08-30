import 'package:flutter/material.dart';
import 'gradiant_container.dart';
const List<Color> gradiantColors = [
                Color.fromARGB(255, 195, 237, 245),
                Color.fromARGB(255, 0, 18, 133),
              ];
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradiantContainer(gradiantColors),
      ),
    ),
  );
}


