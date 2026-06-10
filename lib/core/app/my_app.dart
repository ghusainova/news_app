import 'package:flutter/material.dart';
import 'package:news_app/features/users/presentation/screens/users_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UsersPage(),
    );
  }
}
