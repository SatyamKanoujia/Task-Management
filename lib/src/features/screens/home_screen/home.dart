import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/constants/utils.dart';
import 'package:task_management/src/features/screens/monitoring/monitoring_screen.dart';
import 'package:task_management/src/features/screens/profile_screen/profile_screen.dart';
import 'package:task_management/src/features/screens/tasks/task_view.dart';
import 'package:task_management/src/features/screens/tasks/widgets/task_widget.dart';
import 'package:task_management/src/features/services/account_services.dart';
import 'package:task_management/src/features/services/task_services.dart';
import 'package:task_management/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;
  final TaskServices taskServices = TaskServices();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllTasks();
  }

  void deleteTask(Task task, int index) {
    taskServices.deleteTask(
      context: context,
      task: task,
      onSuccess: () {
        tasks!.removeAt(index);
        setState(() {});
      },
    );
  }

  void updateTaskStatus(Task task) {
    taskServices.updateTaskStatus(
      context: context,
      taskId: task.id!,
      isCompleted: task.isCompleted,
      onSuccess: () {
        setState(() {});
      },
    );
  }

  fetchAllTasks() async {
    tasks = await taskServices.fetchAllTasks(context);
    setState(() {
      isLoading = false;
    });
  }

  void refreshTasks() {
    setState(() {
      isLoading = true;
    });
    fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Management',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return TaskView(
                    onTaskAdded: refreshTasks,
                  );
                }),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 250, 250, 250),
            ),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userProvider.user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor),
              title: const Text('Monitoring'),
              onTap: () {
                // Navigate to monitoring screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MonitoringScreen();
                  }),
                );
              },
            ),
            ListTile(
              leading: const Icon(AntDesign.logout),
              title: const Text('Log Out'),
              onTap: () {
                AccountServices().logOut(context);
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(
                      lottieURL,
                      animate: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Loading...'),
                ],
              ),
            )
          : tasks!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(
                          lottieURL,
                          animate: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(MyString.doneAllTask),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: tasks!.length,
                  itemBuilder: (context, index) {
                    return TaskWidget(
                      task: tasks![index],
                      deleteTask: deleteTask,
                      index: index,
                      onUpdateStatus: updateTaskStatus,
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        onPressed: refreshTasks,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
