import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/task_provider.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/features/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
