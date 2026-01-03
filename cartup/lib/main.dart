import 'package:cartup/widgets/yourgroceries.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CartUP',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 27, 152, 168),
          surface: const Color.fromARGB(255, 0, 16, 19),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 50, 58, 60),
      ),
      home: Scaffold(body: YourGroceries()),
    );
  }
}
