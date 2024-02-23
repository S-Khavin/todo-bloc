import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/pages/todo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, todoList) {
           final int todoCount = todoList.where((todo) => !todo.isCompleted).length;
           final int completedCount = todoList.where((todo) => todo.isCompleted).length;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoPage(),
                          ),
                        ),
                    child: Text("Todo Count : $todoCount")),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoPage(),
                          ),
                        ),
                    child:
                        Text("Completed Count : $completedCount")),
              ],
            ),
          );
        },
      ),
    );
  }
}
