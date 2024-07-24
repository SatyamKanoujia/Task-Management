import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/features/screens/tasks/components/custome_textfield.dart';
import 'package:task_management/src/features/screens/tasks/widgets/task_view_appbar.dart';
import 'package:task_management/src/features/services/task_services.dart';
import 'package:task_management/utils/strings.dart';

class TaskView extends StatefulWidget {
  final VoidCallback onTaskAdded;

  final Task? existingTask;
  const TaskView({
    super.key,
    required this.onTaskAdded,
    this.existingTask,
  });

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();
  final TaskServices taskServices = TaskServices();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final _addTaskFormKey = GlobalKey<FormState>();
  bool isLoading = true;
  List<Task>? tasks;

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      titleTaskController.text = widget.existingTask!.title;
      descriptionTaskController.text = widget.existingTask!.description;
      selectedDate = DateTime.parse(widget.existingTask!.date);
      selectedTime = TimeOfDay(
        hour: int.parse(widget.existingTask!.time.split(':')[0]),
        minute: int.parse(widget.existingTask!.time.split(':')[1]),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleTaskController.dispose();
    descriptionTaskController.dispose();
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

  void addOrUpdateTask() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_addTaskFormKey.currentState!.validate()) {
      if (selectedDate != null && selectedTime != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        String formattedTime = formatTimeOfDay(selectedTime!);

        if (widget.existingTask == null) {
          // Add new task
          taskServices.addTask(
            uid: userProvider.user.id,
            context: context,
            title: titleTaskController.text,
            description: descriptionTaskController.text,
            date: formattedDate,
            time: formattedTime,
            isCompleted: false,
            onSuccess: () {
              widget.onTaskAdded();
              Navigator.pop(context);
            },
          );
        } else {
          // Update existing task
          taskServices.updateTask(
            uid: userProvider.user.id,
            context: context,
            taskId: widget.existingTask!.id!,
            title: titleTaskController.text,
            description: descriptionTaskController.text,
            date: formattedDate,
            time: formattedTime,
            isCompleted: widget.existingTask!.isCompleted,
            onSuccess: () {
              widget.onTaskAdded();
              Navigator.pop(context);
            },
          );
        }
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.warning,
            title: 'Oops!',
            message: 'Please select both date and time!',
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _addTaskFormKey,
              child: Column(
                children: [
                  buildTopSideTexts(context),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            MyString.titleOfTitleTextField,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          controller: titleTaskController,
                          hintText: 'Task Title',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: descriptionTaskController,
                          hintText: 'Description',
                          maxLines: 7,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDate == null
                                            ? "Select a Date"
                                            : 'Date ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          selectDate(context);
                                        },
                                        label: const Text("Select Date"),
                                        icon: const Icon(
                                          Icons.date_range_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedTime == null
                                            ? "Select a Time"
                                            : 'Time ${selectedTime!.format(context)}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          selectTime(context);
                                        },
                                        icon: const Icon(
                                          Icons.timer_sharp,
                                          color: Colors.black,
                                        ),
                                        label: const Text("Select Time"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  if (widget.existingTask == null) {
                                    Navigator.pop(context);
                                  } else {
                                    taskServices.deleteTask(
                                      context: context,
                                      task: widget.existingTask!,
                                      onSuccess: () {
                                        Navigator.pop(context);
                                        widget.onTaskAdded;
                                        refreshTasks();
                                      },
                                    );
                                  }
                                },
                                minWidth: 150,
                                color: Colors.red.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 55,
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                    ),
                                    Text(
                                      MyString.deleteTask,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: addOrUpdateTask,
                                minWidth: 150,
                                color: Colors.blue.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 55,
                                child: Row(
                                  children: [
                                    Icon(
                                      widget.existingTask == null
                                          ? Icons.add_box_outlined
                                          : Icons.update,
                                    ),
                                    Text(
                                      widget.existingTask == null
                                          ? MyString.addTaskString
                                          : MyString.updateTaskString,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopSideTexts(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 90,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: widget.existingTask == null
                  ? MyString.addNewTask
                  : MyString.updateCurrentTask,
              style: Theme.of(context).textTheme.displaySmall,
              children: const [
                TextSpan(
                  text: MyString.taskStrnig,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 90,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
