import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
          color: Colors.blue[900],
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          Provider.of<TaskProvider>(context, listen: false).toggleTaskStatus(task.id);
        },
        activeColor: Colors.blue[900],
      ),
      onLongPress: () {
        _showEditTaskDialog(context, task);
      },
      onTap: () {
        Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    final TextEditingController controller = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task', style: TextStyle(color: Colors.blue[900])),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).editTask(task.id, controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Save', style: TextStyle(color: Colors.blue[900])),
            ),
          ],
        );
      },
    );
  }
}
