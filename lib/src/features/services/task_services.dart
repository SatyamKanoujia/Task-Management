// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/constants/error_handling.dart';
import 'package:task_management/src/constants/text_string.dart';
import 'package:task_management/src/constants/utils.dart';

class TaskServices {
  void addTask({
    required BuildContext context,
    required String uid,
    required String title,
    required String description,
    required String date,
    required String time,
    required bool isCompleted,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Task task = Task(
        uid: uid,
        title: title,
        description: description,
        date: date,
        time: time,
        isCompleted: isCompleted,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/task/add-task'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: task.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.success,
              title: 'Added',
              message: 'The task was Added successfully!',
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<List<Task>> fetchAllTasks(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Task> taskList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/task/get-tasks'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            taskList.add(
              Task.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return taskList;
  }

  void deleteTask({
    required BuildContext context,
    required Task task,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/task/delete-task'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': task.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.success,
              title: 'Deleted',
              message:
                  'The task was deleted successfully, Refresh to see changes!',
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void updateTaskStatus({
    required BuildContext context,
    required String taskId,
    required bool isCompleted,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/task/update-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          '_id': taskId,
          'isCompleted': isCompleted,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void updateTask({
    required BuildContext context,
    required String uid,
    required String taskId,
    required String title,
    required String description,
    required String date,
    required String time,
    required bool isCompleted,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Task task = Task(
        id: taskId,
        uid: uid,
        title: title,
        description: description,
        date: date,
        time: time,
        isCompleted: isCompleted,
      );

      http.Response res = await http.put(
        Uri.parse('$uri/task/update-task/$taskId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: task.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                contentType: ContentType.success,
                title: 'Updated',
                message:
                    'Task Updated Successfully Refresh to see Chnages made!',
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            onSuccess();
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<List<Task>> fetchUserTasks(BuildContext context, String uid) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Task> taskList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/task/get-task?uid=$uid'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> tasksJson = jsonDecode(res.body);
          taskList = tasksJson.map((taskMap) => Task.fromMap(taskMap)).toList();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return taskList;
  }

  Future<void> assignTask({
    required BuildContext context,
    required String uid,
    required String title,
    required String description,
    required String date,
    required String time,
    required bool isCompleted,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Task task = Task(
        uid: uid,
        title: title,
        description: description,
        date: date,
        time: time,
        isCompleted: false,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/task/assign-task'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: task.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.success,
              title: 'Assigned',
              message: 'Task Assigned Successfully.',
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
