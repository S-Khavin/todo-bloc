import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.blue, 
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      home: const HomePage());
  }
}
