import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/src/features/services/task_services.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TaskServices _taskServices = TaskServices();

  List<Task> get tasks => _tasks;

  void loadTasks(String userId) async {
    _tasks = await _taskServices.fetchAllTasks(userId as BuildContext);
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
