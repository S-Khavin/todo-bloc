import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/model/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Page"),
      ),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, todoList) {
          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return ListTile(
                  title: Text(todo.description),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      todoBloc.add(ToggleTodoEvent(index));
                      Future.delayed( Duration(seconds : 10), () {
                        todoBloc.add(DeleteTodoEvent(index));
                      });
                    },
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("New Todo"),
                  content: TextField(
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(hintText: "Enter todo description"),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        todoBloc.add(AddTodoEvent(descriptionController.text));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
