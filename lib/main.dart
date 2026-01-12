import 'package:flutter/material.dart';
import 'pages/calculator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Calculadora',
      theme: ThemeData(
        primaryColor: const Color(0xFF003366),
        colorScheme: const ColorScheme(
          primary: Color(0xFF003366),
          secondary: Color(0xFF0066CC),
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: CalculatorPage(),
    );
  }
}
