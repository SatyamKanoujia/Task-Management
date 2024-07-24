import 'dart:convert';

class Task {
  final String uid;
  final String title;
  final String description;
  final String date;
  final String time;
  final String? id;
  bool isCompleted;
  Task({
    required this.uid,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.id,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'id': id,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      uid: map['uid'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      id: map['_id'],
      isCompleted: map['isCompleted'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
