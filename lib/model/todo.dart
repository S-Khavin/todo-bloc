class Todo{
  final String description;
  final bool isCompleted;
  Todo({required this.description,this.isCompleted = false});

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

}
