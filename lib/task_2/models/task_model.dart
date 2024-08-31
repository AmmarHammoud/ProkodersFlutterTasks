class Todo {
  late int? id;
  late String title;
  late bool done;

  Todo({this.id, required this.title, this.done = false});

  @override
  String toString() {
    return 'Todo {id: $id, title: $title, done: $done}';
  }
}
