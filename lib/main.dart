import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ChatGPT chrome extension',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}