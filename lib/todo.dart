class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '001', todoText: 'Buy groceries',),
      ToDo(id: '002', todoText: 'Clean house',),
      ToDo(id: '003', todoText: 'Go for a walk', isDone: true),
      ToDo(id: '004', todoText: 'Get coffee',),
      ToDo(id: '005', todoText: 'Update',),
      ToDo(id: '006', todoText: 'Check emails', isDone: true),
      ToDo(id: '007', todoText: 'Meeting at 7', isDone: true),
      ToDo(id: '008', todoText: 'Work on the project',),
    ];
  }
}