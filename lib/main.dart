import 'package:flutter/material.dart';

import 'screens/language_selection_screen.dart';

void main() {
  runApp(const RozgarMitraApp());
}

class RozgarMitraApp extends StatelessWidget {
  const RozgarMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RozgarMitra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}