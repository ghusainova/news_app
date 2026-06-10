import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/users/presentation/bloc/user_bloc.dart';
import 'package:news_app/features/users/presentation/widgets/user_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocProvider(
        create: (context) =>
            getIt<UserBloc>()..add(const UserEvent.loadUsers()),
        child: const UserList(),
      ),
    );
  }
}
