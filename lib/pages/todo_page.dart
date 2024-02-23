import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/provider.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Page"),
      ),
      body: Consumer(builder: (context,ref, _){
          final todoState  = ref.watch(todoProvider);
          return    ListView.builder(
              itemCount: todoState.length,
              itemBuilder: (context, index) {
                final todo = todoState[index];
                return ListTile(
                  title: Text(todo.description),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (newValue) {
                      ref.read(todoProvider.notifier).toggleCheckbox(index);
                      Future.delayed( const Duration(seconds : 10), () {
                                              ref.read(todoProvider.notifier).deleteTodo(index);

                    });
                    },
                  ),
                );
              }
              );

      }),
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
                        final newTodo = Todo(description: descriptionController.text);
                        ref.read(todoProvider.notifier).addTodo(newTodo);
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
