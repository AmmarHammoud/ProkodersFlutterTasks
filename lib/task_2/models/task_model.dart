class Todo {
  late int? id;
  late String title;
  late String body;
  late bool done;

  Todo({this.id, required this.title, required this.body, this.done = false});

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'body': body, 'done': done};

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    done = json['done'];
  }

  @override
  String toString() {
    return 'Todo {id: $id, title: $title, body: $body, done: $done}';
  }
}
