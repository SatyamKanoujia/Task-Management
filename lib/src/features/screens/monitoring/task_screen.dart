import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskTap;

  const TaskWidget({
    Key? key,
    required this.task,
    required this.onTaskTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaskTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: task.isCompleted
                  ? const Color.fromARGB(154, 72, 255, 69)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ListTile(
              leading: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                  color: task.isCompleted
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: .8,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 3),
                child: Text(
                  task.title,
                  style: TextStyle(
                    color: task.isCompleted
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.description,
                    style: TextStyle(
                      color: task.isCompleted
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w300,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            task.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: task.isCompleted
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Text(
                            task.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: task.isCompleted
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
