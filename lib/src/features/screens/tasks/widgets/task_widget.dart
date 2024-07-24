import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/providers/task_provider.dart';
import 'package:task_management/src/features/screens/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key,
    required this.task,
    required this.deleteTask,
    required this.onUpdateStatus,
    required this.index,
  }) : super(key: key);

  final Task task;
  final Function(Task task, int index) deleteTask;
  final Function(Task task) onUpdateStatus;
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController titleTaskController = TextEditingController();
  TextEditingController descriptionTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleTaskController.text = widget.task.title;
    descriptionTaskController.text = widget.task.description;
  }

  @override
  void dispose() {
    titleTaskController.dispose();
    descriptionTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to task details or edit page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskView(
              onTaskAdded: () {
                Provider.of<TaskProvider>(context, listen: false)
                    .loadTasks(widget.task.uid);
              },
              existingTask: widget.task,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: widget.task.isCompleted
                  ? const Color.fromARGB(154, 72, 255, 69)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: const Offset(0, 4),
                    blurRadius: 10)
              ],
            ),
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.task.isCompleted = !widget.task.isCompleted;
                  });
                  widget.onUpdateStatus(widget.task);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0), width: .8),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 3),
                child: Text(
                  titleTaskController.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    descriptionTaskController.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.task.title,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            widget.task.date,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                          Text(
                            widget.task.time,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
                widget.deleteTask(widget.task, widget.index);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
