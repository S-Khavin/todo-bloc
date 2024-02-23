class TodoEvent {}

class AddTodoEvent extends TodoEvent{
  final String description;
  AddTodoEvent(this.description);
}

class ToggleTodoEvent extends TodoEvent {
  final int index;
  ToggleTodoEvent(this.index); 
}
class DeleteTodoEvent extends TodoEvent{
    final int index;
  DeleteTodoEvent(this.index);
}