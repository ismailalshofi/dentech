import 'package:flutter/material.dart';

void main() {
  runApp(const DenTech());
}

class DenTech extends StatelessWidget {
  const DenTech({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DenTech',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
