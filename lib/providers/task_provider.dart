import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'dart:collection';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void addTask(String title) {
    final task = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(task);
    notifyListeners();
  }

  void editTask(String id, String newTitle) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].title = newTitle;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isDone = !_tasks[taskIndex].isDone;
      notifyListeners();
    }
  }
}
