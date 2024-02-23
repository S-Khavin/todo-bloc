import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 

//bloc
class TodoNotifier extends StateNotifier<List<Todo>>{

TodoNotifier(): super([]);

void addTodo(Todo todo){
  state = [...state,todo];
  saveTodos();
}

//event
void toggleCheckbox(int index){
  state[index].isCompleted = !state[index].isCompleted;
  state = [...state];//state
  saveTodos();
}

void deleteTodo(int index){
    state.removeAt(index);
    state = [...state];//state
    saveTodos();
}

 Future<void> saveTodos() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final todosJson = state.map((todo) => todo.toJson()).toList();
    await sharedPreferences.setString('todos', jsonEncode(todosJson));
  }

  Future<void> loadTodos() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? todosJson = sharedPreferences.getStringList('todos');
    if (todosJson != null) {
      final List<Todo> todos = todosJson.map((encodedTodo) => Todo.fromJson(json.decode(encodedTodo))).toList();

    }
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier,List<Todo>>((ref) {
  return TodoNotifier()..loadTodos();
});

final completedCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoProvider);
  return todos.where((todo) => todo.isCompleted).length;
});

final notCompletedCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoProvider);
  return todos.where((todo) => !todo.isCompleted).length;
});

