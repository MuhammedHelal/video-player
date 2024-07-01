import 'dart:math';

import 'package:flutter/material.dart';

late Color primaryColor;

List<Color> colors = [
  Colors.deepPurple,
  Colors.red,
  Colors.blue,
  Colors.indigo,
  Colors.green,
  Colors.pink,
  Colors.purple,
];
final Random random = Random();

void setPrimaryColor() {
  int index = random.nextInt(colors.length);

  primaryColor = colors[index];
}
