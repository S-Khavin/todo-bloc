import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/model/todo.dart';

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {

  TodoBloc() : super([]) {
    loadTodos();
    on<TodoEvent>((event, emit) {
      switch (event) {
        case AddTodoEvent():
        if(event.description.isNotEmpty){
          emit([...state, Todo(description: event.description)]);
        }
        saveTodos();
          break;
        case ToggleTodoEvent():
         final int index = event.index;
         print(index);
          // Toggle the completion status of a Todo
          final List<Todo> updatedTodos = state.map((todo) {
            if (todo == state[index]) {
              print(index);
              return Todo(
                description: todo.description,
                isCompleted: !todo.isCompleted,
              );
            }
            return todo;
          }).toList();
          emit(updatedTodos);
          saveTodos();
          break;
        case DeleteTodoEvent():
          final int index = event.index;
          final List<Todo> updatedTodos = List.from(state)..removeAt(index);
          emit(updatedTodos);
          break;
        }
    });

    int completedTodoCount() {
    return state.where((todo) => todo.isCompleted).length;
  }
  }
    Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedTodos = state.map((todo) => json.encode(todo.toJson())).toList();
    await prefs.setStringList('todos', encodedTodos);
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedTodos = prefs.getStringList('todos');
    if (encodedTodos != null) {
      final List<Todo> todos = encodedTodos.map((encodedTodo) => Todo.fromJson(json.decode(encodedTodo))).toList();
      emit(todos);
    }
  }
}

