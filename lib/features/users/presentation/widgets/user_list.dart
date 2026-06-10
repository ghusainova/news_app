import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/users/presentation/bloc/user_bloc.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return state.whenOrNull(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (users) => ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text('Age: ${user.age}'),
                  );
                },
              ),
              error: (message) => Center(child: Text(message)),
            ) ??
            const Center(child: CircularProgressIndicator());
      },
    );
  }
}
