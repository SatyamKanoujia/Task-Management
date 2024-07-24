// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task_management/models/user.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/src/features/screens/monitoring/assigntask_screen.dart';
import 'package:task_management/src/features/services/auth_services.dart';
import 'package:task_management/src/features/services/task_services.dart';
import 'package:task_management/src/features/screens/monitoring/task_screen.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({Key? key}) : super(key: key);

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  List<User>? users;
  bool isLoading = true;
  final AuthService authService = AuthService();
  final TaskServices taskServices = TaskServices();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      List<User> fetchedUsers = await authService.getAllUsers(context);
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchTasksForUser(String userId) async {
    try {
      List<Task> tasks = await taskServices.fetchUserTasks(context, userId);
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'TASK STATUS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'All Tasks Completed!',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskWidget(
                            task: tasks[index],
                            onTaskTap: () {},
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch tasks'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 80),
          child: Text(
            'Monitoring',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users == null || users!.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                  itemCount: users!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        fetchTasksForUser(users![index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            users![index].name,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              text: users![index].position,
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                const TextSpan(text: '\n'),
                                TextSpan(text: users![index].email),
                                const TextSpan(text: '\n'),
                                TextSpan(text: users![index].phoneNumber),
                              ],
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MaterialButton(
                                minWidth: 100,
                                color: Colors.amber.shade400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 55,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AssignTaskScreen(
                                        user: users![index],
                                      ),
                                    ),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.assignment_add),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Assign Task",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          leading: const Icon(Icons.account_circle_outlined),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
