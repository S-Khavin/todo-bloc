import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/todo.dart';

//bloc
class TodoNotifier extends StateNotifier<List<Todo>>{
TodoNotifier(): super([]);

void addTodo(Todo todo){
  state = [...state,todo];
}

//event
void toggleCheckbox(int index){
  state[index].isCompleted = !state[index].isCompleted;
  state = [...state];//state
}

void deleteTodo(int index){
    state.removeAt(index);
    state = [...state];//state
}
}

final todoProvider = StateNotifierProvider<TodoNotifier,List<Todo>>((ref) {
  return TodoNotifier();
});

final completedCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoProvider);
  return todos.where((todo) => todo.isCompleted).length;
});

final notCompletedCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoProvider);
  return todos.where((todo) => !todo.isCompleted).length;
});